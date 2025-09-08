#!/usr/bin/env bash
#
# Codex orchestration entrypoint for A-01 (Frontend Agent)
# - Creates minimal .env if missing (non-secret placeholders only)
# - Sets GitOps mode (ro/rw) based on presence of GITHUB_TOKEN
# - Runs setup.sh (soft-fail already) and maintenance.sh (in loose mode)
# - Never logs secret values
# ----------------------------------------------------------------------------

set -euo pipefail

LOG()  { echo "[INFO] $*"; }
WARN() { echo "[WARN] $*" >&2; }
ERR()  { echo "[ERROR] $*" >&2; }

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

cd "$ROOT_DIR"

# ------------------------------------------------------------
# Minimal non-secret env bootstrap (only for first run)
# ------------------------------------------------------------
if [[ ! -f .env ]]; then
  LOG "No .env found — creating a minimal non-secret .env"
  cat > .env <<'EOF'
# Minimal Codex bootstrap (non-secret)
NODE_ENV=development
FRONTEND_AGENT_VERSION=dev
# Often provided via TFC/Actions at runtime; placeholder is fine here:
VUE_APP_API_URL=http://localhost:8080
EOF
fi

# Ensure npm/node workspaces don’t break due to safe-dir
if command -v git >/dev/null 2>&1; then
  git config --global --add safe.directory "$(pwd)" || true
fi

# ------------------------------------------------------------
# Decide GitOps mode based on token presence
# ------------------------------------------------------------
if [[ -n "${GITHUB_TOKEN:-}" ]]; then
  export CODEX_GITOPS_MODE="rw"
else
  export CODEX_GITOPS_MODE="ro"
fi
LOG "GitOps mode: ${CODEX_GITOPS_MODE}"

# ------------------------------------------------------------
# Run setup (already soft-fails on missing Git vars)
# ------------------------------------------------------------
if [[ -x ./scripts/setup.sh ]]; then
  LOG "Running setup.sh"
  if ! ./scripts/setup.sh; then
    WARN "setup.sh reported warnings (continuing)"
  fi
else
  WARN "scripts/setup.sh not found or not executable — skipping"
fi

# ------------------------------------------------------------
# Run maintenance in loose mode so missing app envs don’t kill the boot
# ------------------------------------------------------------
export ENV_VALIDATE_STRICT="false"

if [[ -x ./scripts/maintain.sh ]]; then
  LOG "Running maintain.sh (loose env validation)"
  if ! ./scripts/maintain.sh; then
    WARN "maintain.sh reported warnings (continuing)"
  fi
else
  WARN "scripts/maintain.sh not found or not executable — skipping"
fi

LOG "Codex bootstrap finished."
