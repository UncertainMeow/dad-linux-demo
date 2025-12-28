#!/usr/bin/env bash
set -euo pipefail

bold() { printf "\033[1m%s\033[0m\n" "$*"; }
ok()   { printf "  \033[32m✔\033[0m %s\n" "$*"; }
warn() { printf "  \033[33m!\033[0m %s\n" "$*"; }
err()  { printf "  \033[31m✖\033[0m %s\n" "$*"; }
step() { printf "\n\033[1m→ %s\033[0m\n" "$*"; }
have() { command -v "$1" >/dev/null 2>&1; }

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

clear
bold "----------------------------------------"
bold "  Linux Demo Setup"
bold "  Optional. Reversible. Kinda fun."
bold "----------------------------------------"
echo

if ! have sudo; then
  err "sudo not found, this script needs sudo"
  exit 1
fi

step "Getting sudo ready"
sudo -v
ok "Sudo ready"

step "Updating system"
sudo apt update -y
sudo apt upgrade -y
ok "System updated"

step "Installing core tools"
sudo apt install -y \
  git curl wget \
  neovim tmux zsh \
  htop \
  fzf ripgrep \
  bat eza \
  fonts-firacode \
  gnome-tweaks \
  gnome-shell-extensions \
  dconf-cli

ok "Core tools installed"

step "Installing everyday apps"
sudo apt install -y \
  vlc libreoffice \
  gimp

ok "Everyday apps installed"

step "Installing visual polish"
sudo apt install -y papirus-icon-theme
ok "Papirus icon theme installed"

step "Installing fastfetch"
FASTFETCH_INSTALLED="no"

if sudo apt install -y fastfetch >/dev/null 2>&1; then
  FASTFETCH_INSTALLED="yes"
  ok "Fastfetch installed via apt"
else
  warn "Fastfetch not available via apt, trying snap"
  if have snap; then
    sudo snap install fastfetch || true
    if have fastfetch; then
      FASTFETCH_INSTALLED="yes"
      ok "Fastfetch installed via snap"
    else
      warn "Fastfetch not found in PATH yet"
    fi
  else
    warn "snap not found, skipping fastfetch"
  fi
fi

step "Applying visible settings by script"
if [ -x "$REPO_ROOT/scripts/apply-settings.sh" ]; then
  bash "$REPO_ROOT/scripts/apply-settings.sh" || warn "Settings apply had issues"
else
  warn "apply-settings.sh not found or not executable"
fi

step "Pulling dotfiles (optional)"
cd "$HOME"
DOTFILES_URL="https://github.com/UncertainMeow/dotfiles.git"

if [ -d "$HOME/dotfiles" ]; then
  warn "dotfiles folder already exists, skipping clone"
else
  git clone "$DOTFILES_URL" "$HOME/dotfiles" || warn "Could not clone dotfiles (network?)"
fi
ok "Dotfiles cloned (not applied)"

step "Setting Zsh as default shell (optional)"
if have zsh; then
  chsh -s "$(command -v zsh)" "$USER" || warn "Could not change shell"
  ok "Zsh set as default (log out and back in to take effect)"
else
  warn "Zsh not found"
fi

step "Configuring fastfetch"
mkdir -p "$HOME/.config/fastfetch"
cat << 'EOF' > "$HOME/.config/fastfetch/config.jsonc"
{
  "logo": { "type": "builtin", "source": "linux" },
  "display": { "separator": "  " },
  "modules": [
    "title",
    "separator",
    "os",
    "kernel",
    "uptime",
    "packages",
    "shell",
    "de",
    "wm",
    "terminal",
    "cpu",
    "memory",
    "disk",
    "network"
  ]
}
EOF
ok "Fastfetch configured"

step "Done"
echo
bold "----------------------------------------"
bold "  Setup complete"
bold "----------------------------------------"
echo

if [ "$FASTFETCH_INSTALLED" = "yes" ] && have fastfetch; then
  fastfetch || true
else
  warn "Fastfetch not installed, you can still run the demo"
fi

echo
echo "Settings as a file demo"
echo "  bash scripts/backup-settings.sh"
echo
echo "Screenshot helper"
echo "  bash scripts/demo-screenshot.sh"
