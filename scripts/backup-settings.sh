#!/usr/bin/env bash
set -euo pipefail

ok()   { printf "  \033[32m✔\033[0m %s\n" "$*"; }
warn() { printf "  \033[33m!\033[0m %s\n" "$*"; }
have() { command -v "$1" >/dev/null 2>&1; }

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

OUT_DIR="$REPO_ROOT/settings"
OUT_FILE="$OUT_DIR/dconf-backup.txt"

if ! have dconf; then
  warn "dconf not found, installing dconf-cli"
  sudo apt update -y
  sudo apt install -y dconf-cli
fi

mkdir -p "$OUT_DIR"
dconf dump / > "$OUT_FILE"
ok "Saved settings to $OUT_FILE"

echo
echo "Next step"
echo "  git add settings/dconf-backup.txt"
echo "  git commit -m \"Save desktop settings\""
