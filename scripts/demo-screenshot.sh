#!/usr/bin/env bash
set -euo pipefail

echo
echo "Open these apps and arrange them nicely:"
echo "  - Terminal (run fastfetch)"
echo "  - Files"
echo "  - Browser"
echo "  - htop (in Terminal)"
echo
echo "Then press Enter and you'll get the interactive screenshot tool."
read -r

if ! command -v gnome-screenshot >/dev/null 2>&1; then
  echo "gnome-screenshot not found. Installing..."
  sudo apt update -y
  sudo apt install -y gnome-screenshot
fi

gnome-screenshot -i
