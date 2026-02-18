#!/bin/bash

DEFAULT_WALL="$HOME/pictures/wallpapers/Retro-Room.png"
CACHE_FILE="$HOME/.cache/current_wallpaper"

if [ -f "$CACHE_FILE" ]; then
    WALL=$(cat "$CACHE_FILE")
else
    WALL="$DEFAULT_WALL"
fi

# For swww
swww img "$WALL" --transition-type fade --transition-duration 1

