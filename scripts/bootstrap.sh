#!/usr/bin/env bash
set -euo pipefail

# Demo-only bootstrap for a fresh Zorin OS user account.
# Goal: fast, readable output, minimal risk, maximum "wow".

bold() { printf "\033[1m%s\033[0m\n" "$*"; }
ok()   { printf "  \033[32m✔\033[0m %s\n" "$*"; }
warn() { printf "  \033[33m!\033[0m %s\n" "$*"; }
step() { printf "\n\033[1m→ %s\033[0m\n" "$*"; }

clear
bold "----------------------------------------"
bold "  Linux Demo Setup"
bold "  Optional. Reversible. Kinda fun."
bold "----------------------------------------"
echo

if ! command -v sudo >/dev/null 2>&1; then
  echo "This script needs sudo."
  exit 1
fi

step "Updating system"
sudo apt update -y
sudo apt upgrade -y
ok "System updated"

step "Installing core tools"
sudo apt install -y \
  git curl wget \
  neovim tmux zsh \
  fastfetch htop \
  fzf ripgrep \
  bat eza \
  fonts-firacode \
  gnome-tweaks \
  gnome-shell-extensions

ok "Core tools installed"

step "Installing everyday apps (safe, familiar)"
sudo apt install -y \
  vlc libreoffice \
  gimp

ok "Everyday apps installed"

step "Installing visual polish"
sudo apt install -y \
  papirus-icon-theme

gsettings set org.gnome.desktop.interface icon-theme "Papirus" || true
ok "Papirus icons enabled"

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
if command -v zsh >/dev/null 2>&1; then
  chsh -s "$(command -v zsh)" "$USER" || warn "Could not change shell (you can do it later)"
  ok "Zsh set as default (log out and back in to take effect)"
else
  warn "Zsh not found"
fi

step "Configuring fastfetch (the reveal)"
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
fastfetch || true

echo
echo "Next:"
echo "  1) Open Tweaks and bump font size a touch"
echo "  2) Pin a few apps to the dock"
echo "  3) Arrange a clean desktop, then run: bash scripts/demo-screenshot.sh"
