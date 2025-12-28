#!/usr/bin/env bash
set -euo pipefail

SRC="$(cd "$(dirname "$0")/../assets/wallpapers" && pwd)"
DST="$HOME/Pictures/Wallpapers"
mkdir -p "$DST"

echo "1) City skyline"
echo "2) Foggy forest"
echo "3) Poly mountains"
read -p "Pick wallpaper (default 3): " c

case "${c:-3}" in
  1) f="a_city_skyline_with_a_tall_building.jpg" ;;
  2) f="a_foggy_forest_with_trees_and_bushes.png" ;;
  *) f="poly_mtns.jpg" ;;
esac

cp "$SRC/$f" "$DST/$f"

gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark' || true
gsettings set org.gnome.desktop.interface gtk-theme 'ZorinBlue-Dark' || true
gsettings set org.gnome.desktop.interface icon-theme 'Papirus' || true
gsettings set org.gnome.desktop.background picture-uri "file://$DST/$f" || true
gsettings set org.gnome.desktop.background picture-uri-dark "file://$DST/$f" || true

echo "Desktop configured"
