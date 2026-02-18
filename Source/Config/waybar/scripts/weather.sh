#!/usr/bin/env bash

LOCATION="$1"
CACHE="$HOME/.cache/waybar-weather.json"

# 1️⃣ Instant display from cache or placeholder
if [[ -f "$CACHE" ]]; then
  cat "$CACHE"
else
  echo '{"text":" ...","tooltip":"Loading weather"}'
fi

# 2️⃣ Background fetch (doesn't block Waybar)
(
  text=$(curl -4 -s --max-time 2 "http://wttr.in/${LOCATION}?format=1")
  tooltip=$(curl -4 -s --max-time 2 "http://wttr.in/${LOCATION}?format=4")

  if [[ -n "$text" && -n "$tooltip" ]]; then
    # clean spaces
    text=$(echo "$text" | sed -E 's/\s+/ /g')
    tooltip=$(echo "$tooltip" | sed -E 's/\s+/ /g')

    # update cache
    echo "{\"text\":\"$text\", \"tooltip\":\"$tooltip\"}" > "$CACHE"
  fi
) & disown

