# Terraform & Workflow Alignment Plan (A-01)

## Objectives
- Remove legacy environment variables and secrets references that no longer exist in Terraform Cloud.
- Confirm Terraform configuration lives entirely under `infra/` and references the standardized variable set.
- Update GitHub Actions workflows so Terraform commands execute from the `infra/` directory.
- Provide documentation and validation notes to keep local, GitHub Actions, and Terraform Cloud behavior in sync.

## Targeted Updates

### Terraform Configuration
- Normalize variable declarations in `infra/agent-variables.tf` so that every Terraform Cloud workspace variable is represented.
- Introduce `infra/variables.tfvars` documenting expected workspace variables (non-sensitive placeholders only).
- Verify `infra/agent-setup.tf` references only the standardized variables (e.g., `var.AGENT_ACTIONS`).

### GitHub Workflows
- `.github/workflows/tfc-sync.yml`: add `working-directory: ./infra` for `init`, `plan`, and `apply` steps; confirm secret names align with Terraform Cloud (`TFC_TOKEN`, `AGENT_ACTIONS`).
- `.github/workflows/verify-env-vars.yml`: refresh required variable list to match Terraform Cloud workspace variables and remove deprecated Notion-only checks if they no longer exist.

### Documentation & Reporting
- Capture summary of changes and validation steps in `docs/terraform-alignment-report.md` for future audits.

## Validation Steps
- Run `terraform fmt` and `terraform validate` inside `infra/` (using placeholder credentials where required).
- Execute `terraform plan` locally only if a valid GitHub token is available; otherwise rely on Terraform Cloud workspace run via the `tfc-sync` workflow.
- Trigger the `tfc-sync / terraform` GitHub Action after committing changes to confirm Terraform Cloud picks up the configuration under `infra/`.

## Open Questions / Assumptions
- Sensitive tokens will continue to be sourced from Terraform Cloud workspace variables (`AGENT_ACTIONS`, `AGENT_COLLAB`, `NOTION_TOKEN`, etc.).
- GitHub secret `TFC_TOKEN` remains the authentication mechanism for the Terraform Cloud API in workflows.
