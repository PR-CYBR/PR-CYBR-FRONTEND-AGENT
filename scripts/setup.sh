#!/usr/bin/env bash
#
# A-01 (FRONTEND-AGENT) — Codex Environment Setup Script (GitOps-focused)
#
# This script ensures the Codex environment has the required Git variables
# to perform repo actions (commits, pushes, PRs). App-level variables are ignored.
#
# Usage:
#   ./setup.sh
#
# Notes:
#   • No secrets are logged.
#   • Validates Git-related env vars; if missing, continues in read-only mode.
# ----------------------------------------------------------------------------

set -euo pipefail

LOG() { echo "[INFO] $*"; }
WARN() { echo "[WARN] $*" >&2; }
ERR() { echo "[ERROR] $*" >&2; }

# ----------------------------------------------------------------------------
# Load .env if present (local/dev convenience)
# ----------------------------------------------------------------------------
if [[ -f .env ]]; then
  LOG "Loading environment from .env"
  # shellcheck disable=SC2046
  export $(grep -v '^#' .env | xargs)
fi

# ----------------------------------------------------------------------------
# Make this repo a safe Git directory (common in CI/containers)
# ----------------------------------------------------------------------------
if command -v git >/dev/null 2>&1; then
  git config --global --add safe.directory "$(pwd)" || true
fi

# ----------------------------------------------------------------------------
# Validate Git-related environment variables (soft-fail)
# ----------------------------------------------------------------------------
REQUIRED_VARS=(GIT_AUTHOR_NAME GIT_AUTHOR_EMAIL GITHUB_REPOSITORY GITHUB_TOKEN)
MISSING=()
for VAR in "${REQUIRED_VARS[@]}"; do
  [[ -z "${!VAR:-}" ]] && MISSING+=("$VAR")
done

if (( ${#MISSING[@]} )); then
  WARN "Missing Git variables: ${MISSING[*]}"
  WARN "Proceeding in read-only mode (no commits/PRs will be attempted)."
  export CODEX_GITOPS_MODE="ro"
else
  export CODEX_GITOPS_MODE="rw"
  LOG "All required Git environment variables are set"
  # Configure Git identity (don’t echo values)
  git config --global user.name  "${GIT_AUTHOR_NAME}"  || true
  git config --global user.email "${GIT_AUTHOR_EMAIL}" || true
fi

# ----------------------------------------------------------------------------
# Optional: install Node dependencies for lint/tests (best-effort)
# ----------------------------------------------------------------------------
if command -v node >/dev/null 2>&1 && command -v npm >/dev/null 2>&1 && [[ -f package.json ]]; then
  if [[ -f package-lock.json ]]; then
    LOG "Installing Node dependencies (npm ci)…"
    npm ci || WARN "npm ci failed; continuing"
  else
    LOG "Installing Node dependencies (npm install)…"
    npm install || WARN "npm install failed; continuing"
  fi
else
  LOG "Skipping Node install (node/npm or package.json not found)"
fi

LOG "Setup complete. GitOps mode: ${CODEX_GITOPS_MODE}"
