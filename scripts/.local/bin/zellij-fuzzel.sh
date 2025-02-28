#!/usr/bin/env bash

ZJ_SESSIONS=$(zellij list-sessions -n | awk '{print $1, ($0 ~ /EXITED/ ? "(EXITED)" : "")}' | sort -k2,2 | column -t)
NO_SESSIONS=$(echo "${ZJ_SESSIONS}" | wc -l)

if [ "${NO_SESSIONS}" -ge 1 ]; then
    SESSION="$(echo "${ZJ_SESSIONS}" | fuzzel --dmenu | cut -d' ' -f1)"
    if [ ! -z $SESSION ]; then
       alacritty --command zellij attach $SESSION
    fi
fi
