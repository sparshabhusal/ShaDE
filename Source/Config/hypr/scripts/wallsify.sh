#!/usr/bin/bash

# Wallpaper Switcher - Wallsify

# --- CONFIG ---
WALLPAPER_DIR="$HOME/Pictures/wallpapers"
CACHE_DIR="$HOME/.cache/wall-thumbs"
THUMB_SIZE="240x135"

mkdir -p "$CACHE_DIR"
shopt -s nullglob

declare -A file_map
menu_lines=()

# --- BUILD MENU WITH THUMBNAILS ---
for ext in jpg jpeg png; do
    for file in "$WALLPAPER_DIR"/*.$ext; do
        [ -e "$file" ] || continue

        base_name=$(basename "$file")

        # --- PRETTY NAME ---
        pretty_name="$base_name"
        pretty_name="${pretty_name%.*}"              # remove extension
        pretty_name="${pretty_name//_/ }"             # _ -> space
        pretty_name="${pretty_name//-/ }"             # - -> space
        pretty_name="$(echo "$pretty_name" | sed 's/  */ /g; s/^ *//; s/ *$//')"

        # Thumbnail path
        thumb="$CACHE_DIR/$(echo "$file" | md5sum | cut -d' ' -f1).png"
        if [ ! -f "$thumb" ] || [ "$file" -nt "$thumb" ]; then
            convert "$file" -thumbnail "${THUMB_SIZE}^" \
                -gravity center -extent "$THUMB_SIZE" \
                -quality 1000 "$thumb"
        fi

        menu_lines+=("$pretty_name\0icon\x1f$thumb")
        file_map["$pretty_name"]="$file"
    done
done

# If no wallpapers exist
[ ${#menu_lines[@]} -eq 0 ] && {
    echo "No wallpapers found in $WALLPAPER_DIR"
    exit 1
}

# --- ROFI MENU ---
selected=$(printf '%b\n' "${menu_lines[@]}" | rofi \
    -dmenu \
    -show-icons \
    -i \
    -orientation vertical\
    -config ~/.config/rofi/configs/wallsify.rasi \
    -fixed-num-lines)

# --- USER SELECTED SOMETHING ---
if [ -n "$selected" ]; then
    file="${file_map[$selected]}"

    # Ensure swww daemon is running
    pgrep -f swww >/dev/null || nohup swww daemon >/dev/null 2>&1 &
    sleep 0.5

    # Apply wallpaper
    swww img "$file" \
        --transition-type center \
        --transition-duration 0.7 \
        --transition-bezier .5,1.3,.8,1 \
        --transition-fps 60

    sleep 0.25

    # Run pywal
    wal -i "$file" -n -s -t
    echo "$file" > "$HOME/.cache/current_wallpaper"

    # Export pywal colors
    [ -f "$HOME/.cache/wal/colors.sh" ] && source "$HOME/.cache/wal/colors.sh"

    # Reloader Script
    ~/.config/hypr/scripts/reloader.sh

    hyprctl reload
fi

