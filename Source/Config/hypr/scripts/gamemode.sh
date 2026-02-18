#!/bin/bash

# 1. Kill waybar
pkill -x waybar &
sleep 0.15

# 2. Kill nwg-dock-hyprland
pkill -f nwg-dock-hyprland &
sleep 0.15

HYPRGAMEMODE=$(hyprctl getoption animations:enabled | awk 'NR==1{print $2}')

if [ "$HYPRGAMEMODE" = 1 ]; then
    hyprctl --batch "\
        keyword animations:enabled 0;\
        keyword decoration:drop_shadow 0;\
        keyword decoration:blur:enabled 0;\
        keyword general:gaps_in 0;\
        keyword general:gaps_out 0;\
        keyword general:border_size 1;\
        keyword decoration:rounding 0"
    exit
fi

hyprctl reload
