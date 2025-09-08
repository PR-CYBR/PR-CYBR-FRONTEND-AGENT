#!/usr/bin/env bash
#
# A-01 (FRONTEND-AGENT) — Codex Environment Maintenance Script (Bash version)
#
# This script performs routine maintenance tasks:
#   • Cleans up log files
#   • Runs npm lint checks (if available)
#   • Verifies health of the frontend environment
#   • Validates required environment variables against .env.example
#
# Usage:
#   ./maintenance.sh
#
# Notes:
#   • No secrets are logged.
#   • npm steps are best-effort; warnings are shown if npm or package.json are missing.
# ----------------------------------------------------------------------------

set -euo pipefail

LOG() { echo "[INFO] $*"; }
ERR() { echo "[ERROR] $*" >&2; }

LOG "GitOps mode: ${CODEX_GITOPS_MODE:-unknown}"

# ----------------------------------------------------------------------------
# Load .env file if present
# ----------------------------------------------------------------------------
if [[ -f .env ]]; then
  LOG "Loading environment from .env"
  # shellcheck disable=SC2046
  export $(grep -v '^#' .env | xargs)
else
  LOG ".env file not found; using current environment only"
fi

# ----------------------------------------------------------------------------
# Validate required environment variables against .env.example
# ----------------------------------------------------------------------------
REQUIRED_VARS=()
if [[ -f .env.example ]]; then
  LOG "Parsing required variables from .env.example"
  mapfile -t REQUIRED_VARS < <(grep -E '^[A-Z0-9_]+=' .env.example | cut -d '=' -f1)
else
  LOG ".env.example not found; falling back to hardcoded list"
  REQUIRED_VARS=(API_BASE_URL ZEROTIER_NETWORK TAILSCALE_DNS WS_URL SENTRY_DSN)
fi

MISSING=()
for VAR in "${REQUIRED_VARS[@]}"; do
  [[ -z "${!VAR:-}" ]] && MISSING+=("$VAR")
done

if (( ${#MISSING[@]} )); then
  ERR "Missing environment variables: ${MISSING[*]}"
  exit 1
fi
LOG "All required environment variables are set"

# ----------------------------------------------------------------------------
# Cleanup logs
# ----------------------------------------------------------------------------
LOG_DIR="logs"
if [[ -d "$LOG_DIR" ]]; then
  COUNT=$(find "$LOG_DIR" -type f -name "*.log" | wc -l | tr -d ' ')
  if [[ "$COUNT" != "0" ]]; then
    LOG "Cleaning up $COUNT log files in $LOG_DIR"
    rm -f "$LOG_DIR"/*.log || true
  else
    LOG "No log files found in $LOG_DIR"
  fi
else
  LOG "Logs directory not found; skipping cleanup"
fi

# ----------------------------------------------------------------------------
# Run lint check with npm (best-effort)
# ----------------------------------------------------------------------------
if command -v npm >/dev/null 2>&1 && [[ -f package.json ]]; then
  LOG "Running npm run lint"
  if ! npm run lint; then
    ERR "Lint check failed"
  else
    LOG "Lint check passed"
  fi
else
  LOG "Skipping lint check (npm or package.json missing)"
fi

# ----------------------------------------------------------------------------
# Health check placeholder
# ----------------------------------------------------------------------------
if [[ -d "dist" ]]; then
  LOG "Health check: build artifacts present in dist/"
else
  LOG "Health check: dist/ directory missing (build may be required)"
fi

LOG "Maintenance complete."
