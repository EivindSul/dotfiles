#!/usr/bin/env bash

# Default variable values
VERBOSE_MODE=false
SELECTED_WALLPAPER_DIR="$HOME/.config/wallpaper-helper"
SELECTED_WALLPAPER_FILE="$SELECTED_WALLPAPER_DIR/wallpaper"
WALLPAPERS_DIR=$HOME/Pictures/wallpapers/
OUT=/dev/null

# Function to display script usage
usage() {
    echo "Usage: $0 [OPTIONS]"
    echo "Options:"
    echo " -h, --help               Display this help message"
    echo " -v, --verbose            Enable verbose mode"
    echo " -f, --file               FILE Specify an output file"
    echo " -d, --file               FILE Specify an output file"
    echo " -n, --next               Set wallpaper to next in directory"
    echo " -p, --previous           Set wallpaper to previous in directory"
    echo " -i, --init               Set wallpaper to previous selection, or first in the directory"
    echo " -w, --wallpaper-daemon   Set which wallpaper util to use. Default: Hyprpaper"
}

has_argument() {
    [[ ("$1" == *=* && -n ${1#*=}) || ( ! -z "$2" && "$2" != -*)  ]];
}

extract_argument() {
    echo "${2:-${1#*=}}"
}

get_wallpapers() {
    WALLPAPERS=$(find $WALLPAPERS_DIR -type f \( -iname "*.jpg" -o -iname "*.png" \) )
    if [ -z "$WALLPAPERS" ]; then
        echo "No wallpapers were found in $WALLPAPERS_DIR" >&2
        exit 1
    fi
    echo "$WALLPAPERS"
}

save_wallpaper() {
    echo "$1" > $SELECTED_WALLPAPER_FILE
}

set_hyprpaper() {
    MONITOR=$1
    if [ -z $MONITOR ]; then
        echo "No monitor was specified, using the first in the list..." > $OUT
        MONITOR=$( hyprctl -j monitors | jq -r '.[0].name' )
        if [ -z $MONITOR ]; then
            echo "hyprctl monitors did not return monitors, or jq is missing. Exiting." >&2
            exit 1
        fi
    fi

    WALLPAPER=$2
    if [ ! -f $WALLPAPER ]; then
        echo "No valid wallpaper $WALLPAPER was specified, cannot set wallpaper." >&2
        exit 1
    fi

    echo "MONITOR is: $MONITOR" > $OUT
    echo "WALLPAPER is: $WALLPAPER" > $OUT
    echo "--------------------" > $OUT
    echo "Trying: hyprctl hyprpaper preload $WALLPAPER" > $OUT
    hyprctl hyprpaper preload "$WALLPAPER" > $OUT
    echo "Trying: hyprctl hyprpaper wallpaper $MONITOR,$WALLPAPER" > $OUT
    hyprctl hyprpaper wallpaper "$MONITOR,$WALLPAPER" > $OUT

    echo "Unloading unused" > $OUT
    hyprctl hyprpaper unload unused > $OUT
}

get_current_hyprpaper() {
    ACTIVE=$( hyprctl hyprpaper listactive )
    CURRENT_WALLPAPER=$( echo $ACTIVE | awk '{print $NF}')
    echo "$CURRENT_WALLPAPER"
}

get_monitor_hyprpaper() {
    ACTIVE=$( hyprctl hyprpaper listactive )
    MONITOR=$( echo $ACTIVE | awk '{print $1}')
    if [ -z $MONITOR ]; then
        MONITOR=$( hyprctl -j monitors | jq -r '.[0].name' )
    fi

    if [ -z $MONITOR ]; then
        echo "No monitor was found. Aborting." >&2
        exit 1
    fi

    echo "$MONITOR"
}

next_wallpaper() {
    WALLPAPERS="$(get_wallpapers)"
    
    CURRENT_WALLPAPER="$(get_current_hyprpaper)"
    MONITOR="$(get_monitor_hyprpaper)"

    NEXT_WALLPAPER=$( echo "$WALLPAPERS" | grep -A 1 $CURRENT_WALLPAPER | tail --lines 1 )

    if [ ! -n "$NEXT_WALLPAPER" ] ; then
        ERR="NEXT_WALLPAPER is empty"
        echo "$ERR" >&2
        notify-send "$ERR"
        exit 1
    fi

    if [ ! -f "$NEXT_WALLPAPER" ]; then
        ERR="Could not find next_wallpaper at $NEXT_WALLPAPER"
        echo "$ERR" >&2
        notify-send "$ERR"
        exit 1
    fi

    if [ "$NEXT_WALLPAPER" == "$CURRENT_WALLPAPER" ]; then
        echo "Trying to set wallpaper to itself. Assuming current wallpaper is the last in the list." > $OUT
        echo "Changing NEXT_WALLPAPER to the first in the directory!" > $OUT
        NEXT_WALLPAPER=$(echo "$WALLPAPERS" | head --lines 1)
    fi

    set_hyprpaper "$MONITOR" "$NEXT_WALLPAPER"

    save_wallpaper "$NEXT_WALLPAPER"
}

previous_wallpaper() {
    WALLPAPERS="$(get_wallpapers)"

    CURRENT_WALLPAPER="$(get_current_hyprpaper)"
    MONITOR="$(get_monitor_hyprpaper)"

    NEXT_WALLPAPER=$( echo "$WALLPAPERS" | grep -B 1 $CURRENT_WALLPAPER | head --lines 1 )

    if [ ! -n "$NEXT_WALLPAPER" ] ; then
        ERR="NEXT_WALLPAPER is empty"
        echo "$ERR" >&2
        notify-send "$ERR"
        exit 1
    fi

    if [ ! -f "$NEXT_WALLPAPER" ]; then
        ERR="Could not find next_wallpaper at $NEXT_WALLPAPER"
        echo "$ERR" >&2
        notify-send "$ERR"
        exit 1
    fi

    if [ "$NEXT_WALLPAPER" == "$CURRENT_WALLPAPER" ]; then
        echo "Trying to set wallpaper to itself. Assuming current wallpaper is the first in the list."
        echo "Changing NEXT_WALLPAPER to the first in the directory!"
        NEXT_WALLPAPER=$(echo "$WALLPAPERS" | tail --lines 1)
    fi

    set_hyprpaper "$MONITOR" "$NEXT_WALLPAPER"

    save_wallpaper "$NEXT_WALLPAPER"
}

init_wallpaper(){
    if [ -f $SELECTED_WALLPAPER_FILE ]; then
        read WALLPAPER < $SELECTED_WALLPAPER_FILE
    else
        echo "No such file: $SELECTED_WALLPAPER_FILE" >&2
        exit 1
    fi

    MONITOR=$( hyprctl -j monitors | jq -r '.[0].name' )

    if [ -z $MONITOR ]; then
            echo "No monitor found." >&2
            exit 1
    fi

    if [ ! -f $WALLPAPER ]; then
            echo "Wallpaper at $WALLPAPER not found." >&2
            exit 1
    fi

    set_hyprpaper "$MONITOR" "$WALLPAPER"
}

# Function to handle options and arguments
handle_options() {
    while [ $# -gt 0 ]; do
        case $1 in
            -h | --help)
                usage
                exit 0
                ;;
            -v | --verbose)
                verbose_mode=true
                OUT=/dev/stdout
                ;;
            -f | --file*)
                if ! has_argument $@; then
                    echo "File not specified." >&2
                    usage
                    exit 1
                fi

                SELECTED_WALLPAPER_FILE=$(extract_argument $@)

                shift
                ;;
            -d | --directory*)
                if ! has_argument $@; then
                    echo "Directory not specified." >&2
                    usage
                    exit 1
                fi

                WALLPAPERS_DIR=$(extract_argument $@)

                shift
                ;;
            -n | --next)
                next_wallpaper
                exit 0
                ;;
            -p | --previous)
                previous_wallpaper
                exit 0
                ;;
            -i | --init)
                init_wallpaper
                exit 0
                ;;
            -w | --wallpaper-daemon)
                echo "TODO! Currently, only hyprpaper is supported." >&2
                exit 1
                ;;
            *)
                echo "Invalid option: $1" >&2
                usage
                exit 1
                ;;
        esac
        shift
    done
}

# Main script execution
handle_options "$@"

# TODO: Make this run every time, after file has been checked, but before anything else runs.
# if [ "$SELECTED_WALLPAPER_FILE" = "$SELECTED_WALLPAPER_DIR/wallpaper"]; then
#     mkdir -p $SELECTED_WALLPAPER_DIR
# fi
