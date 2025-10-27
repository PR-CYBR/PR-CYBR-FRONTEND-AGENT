# Notion Sync Workflow

This document describes how the project integrates Notion databases with the issue tracker using workflow automations (Zapier and n8n). It covers the Notion data models, webhook triggers, cross-link storage, and error handling.

## Notion Data Models

### `A-01-PROJECTS-DB`

| Field | Type | Description |
| --- | --- | --- |
| **Name** | Title | Human-readable project title. Serves as the primary identifier in Notion.
| **Project ID** | Text | Unique slug used when syncing with external services (e.g., `proj-alpha`).
| **Status** | Select | Lifecycle stage (e.g., `Backlog`, `Active`, `Blocked`, `Complete`). Used to drive automation branching.
| **Priority** | Select | Priority tier (`P0`, `P1`, etc.) to inform triage ordering.
| **Owner** | People | Primary project manager or engineer.
| **Squad** | Multi-select | Associated team(s) or functional areas.
| **Roadmap Link** | URL | Points to a high-level planning artifact (roadmap doc or Miro board).
| **GitHub Epic** | URL | Optional link to the corresponding GitHub issue or milestone.
| **Summary** | Rich Text | Executive summary of scope and goals.
| **Kickoff Date** | Date | Planned start date for tracking lead time.
| **Target Delivery** | Date | Target completion date for burndown reporting.
| **Metrics Dashboard** | URL | Observability dashboard for success metrics.
| **Active Tasks (Relation)** | Relation to `A-01-TASK-DB` | Shows tasks connected to the project; reverse relation stored in tasks as `Project`.

### `A-01-TASK-DB`

| Field | Type | Description |
| --- | --- | --- |
| **Name** | Title | Task title, typically mirrors GitHub issue title.
| **Task ID** | Text | Unique external identifier, usually the GitHub issue number or Jira key.
| **Status** | Select | Status values: `Todo`, `In Progress`, `Blocked`, `Ready for Review`, `Done`.
| **Priority** | Select | Task-level urgency (`P0`–`P3`).
| **Assignee** | People | Directly responsible individual.
| **Project** | Relation to `A-01-PROJECTS-DB` | Links task to its parent project. Enables roll-up of status metrics.
| **Issue URL** | URL | Direct link to the synced GitHub issue for fast navigation.
| **Notion URL** | Formula (using `concat()` with `notion.url`) | Self-referential link used by webhooks to populate cross-references.
| **Type** | Select | Task category (`Feature`, `Bug`, `Chore`, `Docs`).
| **Complexity** | Select | Sizing (`XS`–`XL`) to inform capacity planning.
| **Due Date** | Date | Delivery commitment used in reminders.
| **Labels** | Multi-select | Mirrors issue labels.
| **Last Synced** | Date | Timestamp of last successful webhook sync (updated by automation).
| **Completion Feedback** | Rich Text | Stores the retro summary pushed from issue tracker on closure.

## Automation Triggers and Webhooks

The integration uses Zapier for high-level orchestration and n8n for more complex branching logic. Webhooks originate from both GitHub and Notion.

### Task Creation & Update Sync

1. **Trigger:** GitHub webhook (`issues` events for `opened`, `edited`, `reopened`).
2. **Zapier Catch Hook:** Receives issue payload, filters to repositories managed by this workspace.
3. **n8n Workflow:**
   - Parses issue payload, maps labels and assignees to Notion fields.
   - Upserts entry in `A-01-TASK-DB` based on `Task ID`.
   - Ensures relation to the correct project using `Project ID` lookup.
4. **Notion Update Webhook:** When task properties change in Notion (status, priority, assignee), an outgoing webhook notifies n8n.
5. **n8n ↦ GitHub:** Applies corresponding updates to the issue (labels, assignee, project field in body) while respecting rate limits.

### Issue Status and Comment Sync

- **Trigger:** Notion status change to `Ready for Review` or `Done`.
- **Automation:** Zapier monitors property changes via the Notion API and triggers n8n to post a status comment on the GitHub issue, reflecting the new Notion status and due date.
- **Reverse Trigger:** GitHub issue transitions (e.g., label `status: done`, closed events) call the same Zap to push the update into Notion's `Status` and `Last Synced` properties.

### Completion Feedback Loop

- **Trigger:** GitHub issue closed event.
- **n8n Flow:** Fetches closing comment or pull request merge summary, composes a formatted summary, and updates the `Completion Feedback` field in Notion.
- **Zapier Notification:** Posts a Slack message tagging the task owner with the summary and a link back to the Notion task for final review.

## Cross-Link Storage

- **In Notion Tasks:** `Issue URL` stores the canonical GitHub issue link. This is set/updated by the automation whenever an issue is created or its repository/number changes.
- **In GitHub Issues:** The automation injects a `Notion Task` section in the issue body containing the `Notion URL`. Updates merge gracefully by replacing the section delimited with HTML comments (`<!-- Notion Task Start -->` / `<!-- Notion Task End -->`).
- **Projects:** `GitHub Epic` field in `A-01-PROJECTS-DB` points to a GitHub tracking issue or milestone. The issue description reciprocally lists the Notion project URL.

## Failure Handling

- **Retry Logic:** n8n nodes are configured with exponential backoff (max 5 retries) for transient API failures. Zapier steps use built-in retry (up to 3 attempts) before flagging a task as errored.
- **Dead Letter Queue:** Failures exceeding retry thresholds are logged to a dedicated n8n queue. Zapier forwards the payload to a Slack `#automation-alerts` channel with diagnostic metadata.
- **Manual Re-sync:** Operators can trigger a manual resync by rerunning the n8n workflow with the `Task ID` or `Project ID`. Documentation for the manual runbook resides in the internal wiki.
- **Data Integrity Checks:** Nightly cron job runs in n8n to reconcile cross-links—any tasks missing either `Issue URL` or GitHub issues lacking `Notion Task` sections are reported and queued for remediation.
- **Fallback Storage:** If Notion is unavailable, the automation writes updates to a temporary S3 bucket. Once Notion API access is restored, queued updates replay via an n8n cron trigger.

