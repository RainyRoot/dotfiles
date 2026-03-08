#!/usr/bin/env bash
# chezmoi run_once: copies wallpapers to ~/.local/share/wallpapers/
# Runs only once on first apply (or when this file changes)

set -euo pipefail

WALLPAPER_DIR="$HOME/.local/share/wallpapers"
SOURCE_DIR="$(chezmoi source-path)/assets/wallpapers"

mkdir -p "$WALLPAPER_DIR"

if [ -d "$SOURCE_DIR" ]; then
  cp -n "$SOURCE_DIR"/* "$WALLPAPER_DIR/" 2>/dev/null || true
  echo "Wallpapers copied to $WALLPAPER_DIR"
fi
