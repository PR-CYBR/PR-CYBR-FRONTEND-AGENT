###############################################################################
# PR-CYBR Unified Terraform Configuration - versions.tf
# Defines core version requirements and provider dependencies for all Agents.
###############################################################################

terraform {
  required_version = ">= 1.6.0"

  required_providers {
    null = {
      source  = "hashicorp/null"
      version = "~> 3.2"
    }

    local = {
      source  = "hashicorp/local"
      version = "~> 2.5"
    }
  }
}
