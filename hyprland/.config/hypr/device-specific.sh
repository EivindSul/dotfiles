#!/usr/bin/env bash

if [ "$(hostname)" = "asahi" ]; then
    hyprctl keyword source ~/.config/hypr/hypr-mac.conf 
    # &&
    # hyprctl hyprpaper listactive | awk '{print $1","$3}' | xargs -I {} hyprctl hyprpaper wallpaper {}
fi
