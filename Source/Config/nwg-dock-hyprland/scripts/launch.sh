#!/bin/bash

pkill -f nwg-dock-hyprland &
nwg-dock-hyprland -p bottom -c "rofi -show drun -replace" -x -i 36 -mb 10 
