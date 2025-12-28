#!/usr/bin/env bash
set -euo pipefail

ok()   { printf "  \033[32m✔\033[0m %s\n" "$*"; }
warn() { printf "  \033[33m!\033[0m %s\n" "$*"; }
have() { command -v "$1" >/dev/null 2>&1; }

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

IN_FILE="${1:-$REPO_ROOT/settings/dconf-backup.txt}"

if [ ! -f "$IN_FILE" ]; then
  warn "Backup file not found at $IN_FILE"
  exit 1
fi

if ! have dconf; then
  warn "dconf not found, installing dconf-cli"
  sudo apt update -y
  sudo apt install -y dconf-cli
fi

dconf load / < "$IN_FILE"
ok "Restored settings from $IN_FILE"
