###############################################################################
# PR-CYBR Unified Terraform Configuration - main.tf
# Core baseline logic that links each Agent repository to its Terraform Cloud
# workspace, ensuring synchronization and validation without deploying infra.
###############################################################################

terraform {
  cloud {
    organization = var.TFC_ORGANIZATION

    workspaces {
      name = var.AGENT_ID
    }
  }
}

# --- Providers ---
provider "null" {}
provider "local" {}

# --- Local References ---
locals {
  timestamp  = timestamp()
  validation = "Agent ${var.AGENT_ID} linked with Notion page ${var.NOTION_PAGE_ID}"
  workspace  = "Terraform Cloud workspace: ${var.TFC_ORGANIZATION}/${var.AGENT_ID}"
  environment = upper(var.GLOBAL_ENVIRONMENT)
}

# --- Baseline Validation Resource ---
# This performs a zero-impact check using triggers to confirm variable sync.
resource "null_resource" "agent_sync_validation" {
  triggers = {
    agent_id        = var.AGENT_ID
    notion_page_id  = var.NOTION_PAGE_ID
    environment     = local.environment
    timestamp       = local.timestamp
  }

  provisioner "local-exec" {
    when    = create
    command = "echo '[${local.environment}] ${local.validation} at ${local.timestamp}'"
  }
}

# --- Optional Local Output for Logging ---
resource "local_file" "agent_status" {
  count    = var.ENABLE_LOGGING ? 1 : 0
  filename = "${path.module}/agent-status.log"
  content  = <<EOT
${local.validation}
${local.workspace}
Environment: ${local.environment}
Last validated: ${local.timestamp}
EOT
}
