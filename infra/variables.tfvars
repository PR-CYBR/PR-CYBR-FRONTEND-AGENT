#############################################
# Terraform Cloud Workspace Variable Mapping
# Populate these entries inside Terraform
# Cloud; keep this file in sync with agent-
# variables.tf and GitHub workflow inputs.
#############################################

# --- Docker / Registry ---
DOCKERHUB_TOKEN              = "<set-in-tfc>"
DOCKERHUB_USERNAME           = "pr-cybr-bot"

# --- Global Infrastructure URIs ---
GLOBAL_DOMAIN                = "example.pr-cybr.net"
GLOBAL_ELASTIC_URI           = "https://elastic.example.pr-cybr.net"
GLOBAL_GRAFANA_URI           = "https://grafana.example.pr-cybr.net"
GLOBAL_KIBANA_URI            = "https://kibana.example.pr-cybr.net"
GLOBAL_PROMETHEUS_URI        = "https://prometheus.example.pr-cybr.net"

# --- Networking / Security ---
GLOBAL_TAILSCALE_AUTHKEY     = "<set-in-tfc>"
GLOBAL_TRAEFIK_ACME_EMAIL    = "infra@example.pr-cybr.net"
GLOBAL_TRAEFIK_ENTRYPOINTS   = "web,websecure"
GLOBAL_ZEROTIER_NETWORK_ID   = "<set-in-tfc>"

# --- Agent Tokens ---
AGENT_ACTIONS                = "<set-in-tfc>"
AGENT_COLLAB                 = "<set-in-tfc>"

# --- Terraform Cloud ---
TFC_TOKEN                    = "<set-in-tfc>"

# --- Notion Integrations ---
NOTION_TOKEN                 = "<set-in-tfc>"
NOTION_PAGE_ID               = "00000000000000000000000000000000"
NOTION_DISCUSSIONS_ARC_DB_ID = "00000000000000000000000000000000"
NOTION_ISSUES_BACKLOG_DB_ID  = "00000000000000000000000000000000"
NOTION_KNOWLEDGE_FILE_DB_ID  = "00000000000000000000000000000000"
NOTION_PR_BACKLOG_DB_ID      = "00000000000000000000000000000000"
NOTION_PROJECT_BOARD_BACKLOG_DB_ID = "00000000000000000000000000000000"
NOTION_TASK_BACKLOG_DB_ID    = "00000000000000000000000000000000"
