#!/usr/bin/env bash

if [ "$(hostname)" = "asahi" ]; then
    hyprctl keyword source ~/.config/hypr/hypr-mac.conf
fi
