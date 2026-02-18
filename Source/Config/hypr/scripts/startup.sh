#!/bin/bash

WALLPAPER_DIR="$HOME/Pictures/wallpapers"
DEFAULT_WALL="$WALLPAPER_DIR/Retro-Room.png"
CACHE_FILE="$HOME/.cache/current_wallpaper"

# Start swww
swww-daemon

# Decide wallpaper
if [ -f "$CACHE_FILE" ] && [ -f "$(cat "$CACHE_FILE")" ]; then
    WALL=$(cat "$CACHE_FILE")
else
    WALL="$DEFAULT_WALL"
fi

# Apply wallpaper
swww img "$WALL" --transition-type none

# Run pywal
wal -i "$WALL" -n

