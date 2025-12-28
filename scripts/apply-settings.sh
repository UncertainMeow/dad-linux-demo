#!/usr/bin/env bash
set -euo pipefail

bold() { printf "\033[1m%s\033[0m\n" "$*"; }
ok()   { printf "  \033[32m✔\033[0m %s\n" "$*"; }
warn() { printf "  \033[33m!\033[0m %s\n" "$*"; }
have() { command -v "$1" >/dev/null 2>&1; }

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

WALLPAPER_SRC_DIR="$REPO_ROOT/assets/wallpapers"
WALLPAPER_DST_DIR="$HOME/Pictures/Wallpapers"

CITY="a_city_skyline_with_a_tall_building.jpg"
FOG="a_foggy_forest_with_trees_and_bushes.png"
POLY="poly_mtns.jpg"

choose_wallpaper_interactive() {
  echo
  bold "Wallpaper options"
  echo "  1) City skyline"
  echo "  2) Foggy forest"
  echo "  3) Poly mountains"
  echo
  read -r -p "Pick 1, 2, or 3 (default 3) " pick

  case "${pick:-3}" in
    1) echo "$CITY" ;;
    2) echo "$FOG" ;;
    3) echo "$POLY" ;;
    *) echo "$POLY" ;;
  esac
}

apply_dark_mode() {
  if ! have gsettings; then
    warn "gsettings not found, skipping dark mode"
    return 0
  fi

  gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark' || true
  ok "Dark mode enabled"
}

apply_icons() {
  if ! have gsettings; then
    warn "gsettings not found, skipping icon theme"
    return 0
  fi

  gsettings set org.gnome.desktop.interface icon-theme "Papirus" || true
  ok "Papirus icons enabled"
}

apply_text_scaling() {
  local scale="${TEXT_SCALE:-1.10}"

  if ! have gsettings; then
    warn "gsettings not found, skipping text scaling"
    return 0
  fi

  gsettings set org.gnome.desktop.interface text-scaling-factor "$scale" || true
  ok "Text scaling set to $scale"
}

mime_from_ext() {
  case "${1##*.}" in
    jpg|jpeg) echo "image/jpeg" ;;
    png) echo "image/png" ;;
    *) echo "application/octet-stream" ;;
  esac
}

apply_wallpaper() {
  local selected
  selected="$(choose_wallpaper_interactive)"

  mkdir -p "$WALLPAPER_DST_DIR"

  local src="$WALLPAPER_SRC_DIR/$selected"
  local dst="$WALLPAPER_DST_DIR/$selected"

  if [ ! -f "$src" ]; then
    warn "Wallpaper file not found at $src"
    warn "Skipping wallpaper"
    return 0
  fi

  cp -f "$src" "$dst"
  ok "Wallpaper copied to Pictures/Wallpapers"

  if ! have gsettings; then
    warn "gsettings not found, skipping wallpaper apply"
    return 0
  fi

  local uri="file://$dst"
  gsettings set org.gnome.desktop.background picture-uri "$uri" || true
  gsettings set org.gnome.desktop.background picture-uri-dark "$uri" || true
  gsettings set org.gnome.desktop.background picture-options "zoom" || true
  ok "Wallpaper set to $selected"
}

bold "Applying visible settings"
apply_dark_mode
apply_icons
apply_text_scaling
apply_wallpaper

echo
ok "Settings applied"
