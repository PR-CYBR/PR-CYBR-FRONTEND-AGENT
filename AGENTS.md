# Repository Agent Instructions

## Quick Commands
- **Install:** `./scripts/provision_agent.sh`
- **Test:** `python -m unittest discover tests`
- **Build:** `docker build -f build/Dockerfile .`
- **Lint:** _No project-specific lint command is defined._

## Continuous Integration
- `.github/workflows/build-test.yml` — runs automatically on pushes to `main`.
- `.github/workflows/docker-hub-update.yml` — runs on pushes to `main` that touch `build/Dockerfile` and via manual `workflow_dispatch`.
- `.github/workflows/openai-function.yml` — runs on pushes to `main` and via manual `workflow_dispatch`.

_This repository currently defines no workflows triggered by `repository_dispatch` / `codex_run`._

## Required Secrets
- `GITHUB_TOKEN`
- `AGENT_ID`
- `ORG`
- `NOTION_API_KEY`
- `SLACK_WEBHOOK_URL`
- `ZAPIER_WEBHOOK_URL`
- `N8N_API_URL`

## Documentation
Refer to `README.md` for comprehensive human-facing documentation.
