"""Generate changelog content for pushes and update a GitHub Discussion."""

from __future__ import annotations

import json
import os
import re
import subprocess
from datetime import datetime, timezone
from typing import Dict, Iterable, List, Optional, Set, Tuple
from urllib.error import HTTPError
from urllib.parse import urlparse, urlunparse
from urllib.request import Request, urlopen


def _run_git_log(range_spec: str) -> List[Dict[str, str]]:
    """Return commit metadata for the provided git range."""

    pretty_format = "%H%x1f%an%x1f%s%x1f%b%x1e"
    result = subprocess.check_output(
        [
            "git",
            "log",
            f"--pretty=format:{pretty_format}",
            range_spec,
        ]
    )
    raw_commits = result.decode("utf-8").strip("\n\x1e")

    if not raw_commits:
        return []

    commits: List[Dict[str, str]] = []
    for entry in raw_commits.split("\x1e"):
        if not entry.strip():
            continue
        parts = entry.split("\x1f")
        if len(parts) < 4:
            continue
        sha, author, subject, body = parts[0], parts[1], parts[2], parts[3]
        commits.append(
            {
                "sha": sha,
                "author": author.strip(),
                "subject": subject.strip(),
                "body": body.strip(),
            }
        )
    return commits


_SCOPE_RE = re.compile(r"^[a-zA-Z]+\(([^)]+)\)!?:")
_ISSUE_RE = re.compile(r"(?<!\w)#(\d+)")
_NOTION_RE = re.compile(r"https://(?:www\.)?notion.so/[^\s)]+")


def _extract_scope(subject: str) -> Optional[str]:
    match = _SCOPE_RE.match(subject)
    if match:
        scope = match.group(1).strip()
        return scope or None
    return None


def _sanitize_notion_url(url: str) -> str:
    parsed = urlparse(url)
    sanitized = parsed._replace(query="", fragment="")
    return urlunparse(sanitized)


def _extract_metadata(commit: Dict[str, str]) -> Dict[str, Iterable[str]]:
    text = f"{commit['subject']}\n{commit['body']}"
    issues = sorted({f"#{match}" for match in _ISSUE_RE.findall(text)})
    notion_links = sorted(
        {
            _sanitize_notion_url(url.rstrip(".,;"))
            for url in _NOTION_RE.findall(text)
        }
    )
    scope = _extract_scope(commit["subject"])
    return {
        "issues": issues,
        "notion": notion_links,
        "scope": [scope] if scope else [],
    }


def _format_issue_link(ref: str, repo: str) -> str:
    number = ref.lstrip("#")
    return f"[{ref}](https://github.com/{repo}/issues/{number})"


def _github_request(method: str, url: str, token: str, payload: Optional[Dict] = None) -> Dict:
    data: Optional[bytes] = None
    headers = {
        "Accept": "application/vnd.github+json",
        "Authorization": f"Bearer {token}",
        "User-Agent": "discussion-update-action",
    }
    if payload is not None:
        data = json.dumps(payload).encode("utf-8")
        headers["Content-Type"] = "application/json"

    request = Request(url, data=data, headers=headers, method=method)
    try:
        with urlopen(request) as response:
            content = response.read().decode("utf-8")
            return json.loads(content) if content else {}
    except HTTPError as error:
        body = error.read().decode("utf-8")
        raise RuntimeError(
            f"GitHub API request failed: {error.code} {error.reason}: {body}"
        ) from error


def _find_category_id(repo_api: str, token: str, category_name: str) -> str:
    url = f"{repo_api}/discussions/categories?per_page=100"
    categories = _github_request("GET", url, token)
    for category in categories.get("categories", []):
        if category.get("name", "").lower() == category_name.lower():
            return str(category["id"])
    raise RuntimeError(f"Discussion category '{category_name}' not found")


def _find_existing_discussion(repo_api: str, token: str, title: str, category_id: str) -> Optional[Dict]:
    url = f"{repo_api}/discussions?per_page=100&category_id={category_id}"
    discussions = _github_request("GET", url, token)
    for discussion in discussions:
        if discussion.get("title") == title:
            return discussion
    return None


def _format_changelog(
    repo: str,
    commits: List[Dict[str, str]],
    metadata: List[Dict[str, Iterable[str]]],
) -> Tuple[str, Dict[str, Set[str]]]:
    authors: Set[str] = set()
    scopes: Set[str] = set()
    linked: Set[str] = set()
    notion_refs: Set[str] = set()

    lines: List[str] = []
    now = datetime.now(timezone.utc).strftime("%Y-%m-%d %H:%M UTC")
    head_sha = commits[0]["sha"][:7] if commits else "unknown"
    lines.append(f"## {now} – {head_sha}")
    lines.append("")

    for commit, meta in zip(commits, metadata):
        if commit["author"]:
            authors.add(commit["author"])
        scopes.update(scope for scope in meta["scope"] if scope)
        linked.update(meta["issues"])
        notion_refs.update(meta["notion"])

    if authors:
        lines.append("**Authors:** " + ", ".join(sorted(authors)))
    if scopes:
        lines.append("**Scopes:** " + ", ".join(sorted(scopes)))
    if linked:
        linked_links = ", ".join(_format_issue_link(ref, repo) for ref in sorted(linked))
        lines.append("**Linked Issues/PRs:** " + linked_links)
    if notion_refs:
        lines.append("**Notion:** " + ", ".join(sorted(notion_refs)))

    if len(lines) > 1:
        lines.append("")

    lines.append("### Commits")
    if not commits:
        lines.append("- _No commits found for this push._")
    else:
        for commit, meta in zip(commits, metadata):
            short_sha = commit["sha"][:7]
            url = f"https://github.com/{repo}/commit/{commit['sha']}"
            summary = commit["subject"] or "(no subject)"
            author = commit["author"] or "Unknown author"
            lines.append(f"- [{short_sha}]({url}) {summary} — {author}")

            if meta["scope"]:
                lines.append("  - Scope: " + ", ".join(meta["scope"]))
            if meta["issues"]:
                lines.append(
                    "  - Linked: "
                    + ", ".join(_format_issue_link(ref, repo) for ref in meta["issues"])
                )
            if meta["notion"]:
                lines.append("  - Notion: " + ", ".join(meta["notion"]))

    summary = {
        "authors": authors,
        "scopes": scopes,
        "linked": linked,
        "notion": notion_refs,
    }
    return "\n".join(lines), summary


def main() -> None:
    repo = os.environ.get("GITHUB_REPOSITORY")
    token = os.environ.get("GITHUB_TOKEN")
    from_sha = os.environ.get("FROM_SHA")
    to_sha = os.environ.get("TO_SHA")
    category_name = os.environ.get("DISCUSSION_CATEGORY", "Changelog")
    discussion_title = os.environ.get("DISCUSSION_TITLE", "Automated Changelog")

    if not all([repo, token, to_sha]):
        raise RuntimeError("Missing required environment variables")

    if from_sha and re.fullmatch(r"0+", from_sha):
        range_spec = to_sha
    elif from_sha:
        range_spec = f"{from_sha}..{to_sha}"
    else:
        range_spec = to_sha

    commits = _run_git_log(range_spec)
    if not commits:
        print("No commits detected for changelog generation.")

    metadata = [_extract_metadata(commit) for commit in commits]
    changelog_body, summary = _format_changelog(repo, commits, metadata)

    repo_api = f"https://api.github.com/repos/{repo}"
    category_id = _find_category_id(repo_api, token, category_name)
    existing = _find_existing_discussion(repo_api, token, discussion_title, category_id)

    if existing:
        updated_body = f"{changelog_body}\n\n---\n\n{existing.get('body', '').strip()}".strip()
        _github_request(
            "PATCH",
            f"{repo_api}/discussions/{existing['number']}",
            token,
            {"title": discussion_title, "body": updated_body},
        )
        print(f"Updated discussion #{existing['number']} with new changelog entry.")
    else:
        payload = {
            "title": discussion_title,
            "body": changelog_body,
            "category_id": category_id,
        }
        response = _github_request("POST", f"{repo_api}/discussions", token, payload)
        print(f"Created discussion #{response.get('number')} in category '{category_name}'.")

    print(
        "Authors:",
        ", ".join(sorted(summary["authors"])) if summary["authors"] else "-",
    )
    print(
        "Scopes:",
        ", ".join(sorted(summary["scopes"])) if summary["scopes"] else "-",
    )
    print(
        "Linked:",
        ", ".join(sorted(summary["linked"])) if summary["linked"] else "-",
    )
    print(
        "Notion:",
        ", ".join(sorted(summary["notion"])) if summary["notion"] else "-",
    )


if __name__ == "__main__":
    main()

