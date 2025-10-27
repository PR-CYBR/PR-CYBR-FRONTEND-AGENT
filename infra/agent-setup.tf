#############################################
# PR-CYBR Agent Terraform Bootstrap (A-01)
#
# This configuration intentionally mirrors
# the unified infrastructure standard that
# every PR-CYBR agent repository consumes.
#
# All sensitive values (tokens, credentials,
# workspace metadata) are supplied at runtime
# from Terraform Cloud and mirrored into the
# repository's GitHub secrets via the tfc-sync
# workflow.  Nothing in this file should be
# hardcoded.
#############################################

terraform {
  required_version = ">= 1.6.0"
}

# ----------------------------------------------------------------------------
# Centralised agent metadata.  Keeping this in locals ensures that Terraform
# validate/plan confirms every expected variable is wired up without leaking
# values into the configuration.  Downstream resources can consume this map to
# provision GitHub secrets, Terraform Cloud variables, or other automation.
# ----------------------------------------------------------------------------
locals {
  agent_context = {
    agent_id                           = var.AGENT_ID
    notion_page_id                     = var.NOTION_PAGE_ID
    pr_cybr_docker_user                = var.PR_CYBR_DOCKER_USER
    pr_cybr_docker_pass                = var.PR_CYBR_DOCKER_PASS
    dockerhub_username                 = var.DOCKERHUB_USERNAME
    dockerhub_token                    = var.DOCKERHUB_TOKEN
    global_domain                      = var.GLOBAL_DOMAIN
    agent_actions_token                = var.AGENT_ACTIONS
    notion_token                       = var.NOTION_TOKEN
    notion_discussions_arc_db_id       = var.NOTION_DISCUSSIONS_ARC_DB_ID
    notion_issues_backlog_db_id        = var.NOTION_ISSUES_BACKLOG_DB_ID
    notion_knowledge_file_db_id        = var.NOTION_KNOWLEDGE_FILE_DB_ID
    notion_project_board_backlog_db_id = var.NOTION_PROJECT_BOARD_BACKLOG_DB_ID
    notion_pr_backlog_db_id            = var.NOTION_PR_BACKLOG_DB_ID
    notion_task_backlog_db_id          = var.NOTION_TASK_BACKLOG_DB_ID
    tfc_token                          = var.TFC_TOKEN
  }
}

output "agent_metadata" {
  description = "Reference map containing all Terraform Cloud supplied values."
  value       = local.agent_context
  sensitive   = true
}
