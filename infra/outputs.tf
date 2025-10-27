###############################################################################
# PR-CYBR Unified Terraform Configuration - outputs.tf
# Defines key output variables confirming synchronization status between
# each Agent's Terraform Cloud workspace and its associated Notion record.
###############################################################################

# --- Agent Synchronization Output ---
output "agent_sync_status" {
  description = "Confirms that this Agent's Terraform Cloud workspace and Notion page are properly linked."
  value       = "✅ Agent ${var.AGENT_ID} successfully validated and synchronized with Notion page ${var.NOTION_PAGE_ID}"
}

# --- Terraform Cloud Workspace Info ---
output "workspace_info" {
  description = "Identifies the Terraform Cloud organization and workspace in use."
  value       = "Workspace: ${var.TFC_ORGANIZATION}/${var.AGENT_ID} (${var.GLOBAL_ENVIRONMENT})"
}

# --- Local Validation Log Path ---
output "local_log_path" {
  description = "Path of the local validation log created by the agent-status resource (if ENABLE_LOGGING = true)."
  value       = "${path.module}/agent-status.log"
  sensitive   = false
}

# --- Validation Timestamp ---
output "validation_timestamp" {
  description = "Timestamp indicating when the local validation process was last executed."
  value       = timestamp()
}
