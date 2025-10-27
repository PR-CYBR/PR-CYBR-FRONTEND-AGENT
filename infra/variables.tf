#############################################
# Terraform Cloud Variable Schema (A-01)
# ---------------------------------------
# These declarations mirror the canonical
# Terraform Cloud workspace variables for
# every PR-CYBR agent.  Only AGENT_ID and
# NOTION_PAGE_ID differ per workspace.
#############################################

variable "AGENT_ID" {
  type        = string
  description = "Unique identifier for this PR-CYBR agent (e.g. A-01)."
}

variable "PR_CYBR_DOCKER_USER" {
  type        = string
  description = "Terraform Cloud managed Docker Hub username for PR-CYBR images."
}

variable "PR_CYBR_DOCKER_PASS" {
  type        = string
  sensitive   = true
  description = "Terraform Cloud managed Docker Hub password for PR-CYBR images."
}

variable "DOCKERHUB_USERNAME" {
  type        = string
  description = "Shared Docker Hub username for GitHub Actions logins."
}

variable "DOCKERHUB_TOKEN" {
  type        = string
  sensitive   = true
  description = "Shared Docker Hub token for GitHub Actions logins."
}

variable "GLOBAL_DOMAIN" {
  type        = string
  description = "Primary PR-CYBR domain (pr-cybr.com)."
}

variable "AGENT_ACTIONS" {
  type        = string
  sensitive   = true
  description = "GitHub token used by the tfc-sync workflow."
}

variable "NOTION_TOKEN" {
  type        = string
  sensitive   = true
  description = "Integration token for Notion automation."
}

variable "NOTION_DISCUSSIONS_ARC_DB_ID" {
  type        = string
  description = "Database ID for the discussions ARC backlog."
}

variable "NOTION_ISSUES_BACKLOG_DB_ID" {
  type        = string
  description = "Database ID for the issues backlog board."
}

variable "NOTION_KNOWLEDGE_FILE_DB_ID" {
  type        = string
  description = "Database ID for the shared knowledge file archive."
}

variable "NOTION_PROJECT_BOARD_BACKLOG_DB_ID" {
  type        = string
  description = "Database ID for the unified project backlog board."
}

variable "NOTION_PR_BACKLOG_DB_ID" {
  type        = string
  description = "Database ID for the PR backlog board."
}

variable "NOTION_TASK_BACKLOG_DB_ID" {
  type        = string
  description = "Database ID for the task backlog board."
}

variable "NOTION_PAGE_ID" {
  type        = string
  description = "Agent-specific Notion workspace page ID."
}

variable "TFC_TOKEN" {
  type        = string
  sensitive   = true
  description = "Terraform Cloud API token used for workspace automation."
}
