#!/usr/bin/env bash
echo "Resetting desktop for this user"
read -p "Press Enter to continue"
dconf reset -f /
rm -rf ~/.cache/gnome-shell ~/.local/share/gnome-shell ~/.config/gnome-session
gnome-session-quit --logout --no-prompt
