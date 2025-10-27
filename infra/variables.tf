###############################################################################
# PR-CYBR Unified Terraform Configuration - variables.tf
# Defines all variables required by the baseline Agent configuration.
# Each variable here maps 1:1 with Terraform Cloud workspace variables.
###############################################################################

# --- Agent-Specific Variables ---

variable "AGENT_ID" {
  description = "Unique identifier for the PR-CYBR Agent workspace (e.g., A-01)."
  type        = string
}

variable "NOTION_PAGE_ID" {
  description = "Identifier for the Notion page associated with this Agent."
  type        = string
}

# --- Shared / Organizational Variables ---

variable "GLOBAL_ENVIRONMENT" {
  description = "Specifies the global environment label (codex, stage, prod)."
  type        = string
  default     = "codex"
}

variable "TFC_ORGANIZATION" {
  description = "Terraform Cloud organization name for PR-CYBR Agents."
  type        = string
  default     = "pr_cybr"
}

variable "TFC_WORKSPACE" {
  description = "Workspace name to associate this Agent with inside Terraform Cloud."
  type        = string
  default     = ""
}

variable "ENABLE_LOGGING" {
  description = "Toggle to enable local logging or output writing."
  type        = bool
  default     = true
}

# --- Optional Integration Variables ---

variable "NOTION_TOKEN" {
  description = "API token for secure Notion integration."
  type        = string
  sensitive   = true
}

variable "TERRAFORM_CLOUD_TOKEN" {
  description = "Terraform Cloud API token used for authentication."
  type        = string
  sensitive   = true
}
