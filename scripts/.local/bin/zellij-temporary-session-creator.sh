#!/usr/bin/env bash

# Delete old temporary sessions, but only those marked with EXITED
zellij ls -n | grep -E "temp.*EXITED" | awk '{print $1}' | xargs -I {} zellij delete-session {}

# Get names of existing temp sessions
TEMP_SESSIONS=$(zellij ls -ns | grep -E "temp*") 

# Find the name of the session with the name tempNUM,
# where num is the lowest free number
for i in {1..100}
do
    SESSION_NAME="temp$i"
    if echo $TEMP_SESSIONS | grep -qv $SESSION_NAME; then
        echo "Free name found, $SESSION_NAME"
        zellij -s $SESSION_NAME
        exit 0
    fi
done
