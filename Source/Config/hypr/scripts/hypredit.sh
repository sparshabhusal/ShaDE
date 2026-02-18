#!/bin/bash

choice=$(printf "Hyprland\n\
Kitty\n\
Waybar\n\
Hyprlock\n\
Rofi\n\
Neovim\n\
Wlogout\n" |
rofi -dmenu -theme ~/.config/rofi/configs/hypredit.rasi -p "⚙")

case "$choice" in
  "Hyprland") kitty --hold nvim ~/.config/hypr/ ;;
  "Kitty") kitty --hold nvim ~/.config/kitty/kitty.conf ;;
  "Waybar") kitty --hold nvim ~/.config/waybar/ ;;
  "Hyprlock") kitty --hold nvim ~/.config/hypr/hyprlock.conf ;;
  "Rofi") kitty --hold nvim ~/.config/rofi/config.rasi ;;
  "Neovim") kitty --hold nvim ~/.config/nvim/ ;;
  "Wlogout") kitty --hold nvim ~/.config/wlogout/ ;;
esac

