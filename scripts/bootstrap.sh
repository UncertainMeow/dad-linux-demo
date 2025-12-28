#!/usr/bin/env bash
set -euo pipefail
bold(){ printf "\033[1m%s\033[0m\n" "$*"; }
ok(){ printf "  \033[32m✔\033[0m %s\n" "$*"; }
warn(){ printf "  \033[33m!\033[0m %s\n" "$*"; }
step(){ printf "\n\033[1m→ %s\033[0m\n" "$*"; }

clear
bold "----------------------------------------"
bold "  Linux Demo Setup"
bold "----------------------------------------"

sudo -v
sudo apt update -y && sudo apt upgrade -y

sudo apt install -y git curl wget neovim tmux zsh htop fzf ripgrep bat eza zoxide   fonts-firacode gnome-tweaks gnome-shell-extensions dconf-cli   vlc libreoffice gimp papirus-icon-theme

sudo apt install -y fastfetch || sudo snap install fastfetch || true
export PATH="/snap/bin:$PATH"

bash "$(dirname "$0")/apply-settings.sh"

git clone https://github.com/UncertainMeow/dotfiles.git "$HOME/dotfiles" 2>/dev/null || true

mkdir -p "$HOME/.config"
cat << 'EOF' > "$HOME/.config/zorin-demo.zsh"
if command -v zoxide >/dev/null; then eval "$(zoxide init zsh)"; fi
[ -f /usr/share/doc/fzf/examples/key-bindings.zsh ] && source /usr/share/doc/fzf/examples/key-bindings.zsh
[ -f /usr/share/doc/fzf/examples/completion.zsh ] && source /usr/share/doc/fzf/examples/completion.zsh
export PATH="/snap/bin:$PATH"
EOF

grep -q zorin-demo.zsh ~/.zshrc 2>/dev/null || echo '[ -f "$HOME/.config/zorin-demo.zsh" ] && source "$HOME/.config/zorin-demo.zsh"' >> ~/.zshrc
chsh -s "$(command -v zsh)" "$USER" || true

fastfetch || true
