#!/usr/bin/env bash
set -euo pipefail

echo
echo "----------------------------------------"
echo " Desktop appearance setup"
echo "----------------------------------------"
echo

have() { command -v "$1" >/dev/null 2>&1; }

if ! have gsettings; then
  echo "gsettings not available, cannot apply settings"
  exit 0
fi

WALLPAPER_DIR="$(cd "$(dirname "$0")/../assets/wallpapers" && pwd)"

# -----------------------------
# Dark mode (apps + shell)
# -----------------------------
echo "→ Enabling dark mode"

# GNOME 42+ color scheme (apps)
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark' 2>/dev/null || true

# GTK theme fallback
for theme in \
  ZorinBlue-Dark \
  ZorinDark \
  Adwaita-dark
do
  if gsettings set org.gnome.desktop.interface gtk-theme "$theme" 2>/dev/null; then
    echo "  GTK theme set to $theme"
    break
  fi
done

# Shell theme (taskbar / top bar / dock)
# This is the critical bit for Zorin
if gsettings list-schemas | grep -q org.gnome.shell.extensions.user-theme; then
  for shell_theme in \
    ZorinBlue-Dark \
    ZorinDark \
    Adwaita-dark
  do
    if gsettings set org.gnome.shell.extensions.user-theme name "$shell_theme" 2>/dev/null; then
      echo "  Shell theme set to $shell_theme"
      break
    fi
  done
else
  echo "  Shell theme extension not found (taskbar may stay light until logout)"
fi

# -----------------------------
# Wallpaper picker
# -----------------------------
echo
echo "→ Choose a wallpaper"
echo "1) City skyline"
echo "2) Foggy forest"
echo "3) Poly mountains"
read -rp "Pick wallpaper (default 3): " choice

case "$choice" in
  1)
    WALLPAPER="$WALLPAPER_DIR/a_city_skyline_with_a_tall_building.jpg"
    ;;
  2)
    WALLPAPER="$WALLPAPER_DIR/a_foggy_forest_with_trees_and_bushes.png"
    ;;
  *)
    WALLPAPER="$WALLPAPER_DIR/poly_mtns.jpg"
    ;;
esac

if [ -f "$WALLPAPER" ]; then
  gsettings set org.gnome.desktop.background picture-uri "file://$WALLPAPER"
  gsettings set org.gnome.desktop.background picture-uri-dark "file://$WALLPAPER"
  echo "  Wallpaper applied"
else
  echo "  Wallpaper file not found, skipping"
fi

# -----------------------------
# Minor polish
# -----------------------------
# Slightly larger text for comfort
gsettings set org.gnome.desktop.interface text-scaling-factor 1.1 2>/dev/null || true

echo
echo "Desktop configured"
echo
echo "Note:"
echo "If the taskbar did not flip to dark immediately,"
echo "log out and back in once. GNOME Shell reloads on login."
