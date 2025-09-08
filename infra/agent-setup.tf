terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 6.0"
    }
  }
}

provider "github" {
  token = var.AGENT_ACTIONS
  owner = "PR-CYBR"
}

# Example: enforce a baseline label
resource "github_issue_label" "ci_sync" {
  repository = "PR-CYBR-FRONTEND-AGENT"
  name       = "ci-sync"
  color      = "0366d6"
  description = "Terraform-managed label to confirm sync works"
}
