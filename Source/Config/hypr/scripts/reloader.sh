#!/bin/bash

# Waybar
pkill -x waybar &
sleep 0.1
waybar

# Nwg-dock-hyprland
pkill -f nwg-dock-hyprland 
nwg-dock-hyprland -p bottom -c "rofi -show drun -replace" -x -i 36 -mb 10

# Hyprland
hyprctl reload
