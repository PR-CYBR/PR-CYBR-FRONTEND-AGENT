#############################################
# PR-CYBR A-01 Frontend Agent Variables
# This file declares variables expected by the
# A-01 workspace. Real values are securely
# managed in Terraform Cloud.
#############################################

# --- Shared / Global Variables ---
variable "DOCKERHUB_TOKEN" {
  type        = string
  sensitive   = true
  description = "Docker Hub access token"
}

variable "DOCKERHUB_USERNAME" {
  type        = string
  description = "Docker Hub username"
}

variable "GLOBAL_DOMAIN" {
  type        = string
  description = "Root DNS for PR-CYBR services"
}

variable "GLOBAL_ELASTIC_URI" {
  type        = string
  description = "Elasticsearch endpoint"
}

variable "GLOBAL_GRAFANA_URI" {
  type        = string
  description = "Grafana endpoint"
}

variable "GLOBAL_KIBANA_URI" {
  type        = string
  description = "Kibana endpoint"
}

variable "GLOBAL_PROMETHEUS_URI" {
  type        = string
  description = "Prometheus endpoint"
}

variable "GLOBAL_TAILSCALE_AUTHKEY" {
  type        = string
  sensitive   = true
  description = "Auth key for Tailscale VPN/DNS"
}

variable "GLOBAL_TRAEFIK_ACME_EMAIL" {
  type        = string
  description = "Email used for Let's Encrypt via Traefik"
}

variable "GLOBAL_TRAEFIK_ENTRYPOINTS" {
  type        = string
  description = "Default Traefik entrypoints"
}

variable "GLOBAL_ZEROTIER_NETWORK_ID" {
  type        = string
  sensitive   = true
  description = "Overlay network ID for ZeroTier"
}

variable "AGENT_ACTIONS" {
  type        = string
  sensitive   = true
  description = "Token for CI/CD pipelines"
}

variable "AGENT_COLLAB" {
  type        = string
  sensitive   = true
  description = "Token for governance/collaboration features"
}

# --- Frontend Agent Specific Variables ---
variable "API_BASE_URL" {
  type        = string
  description = "Base URL for Backend Agent (A-02)"
}

variable "WS_URL" {
  type        = string
  description = "WebSocket gateway endpoint"
}
