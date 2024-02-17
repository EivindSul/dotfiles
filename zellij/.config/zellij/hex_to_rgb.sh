#!/bin/bash

hex_to_rgb() {
    hex="$1"
    r=$((16#${hex:1:2}))
    g=$((16#${hex:3:2}))
    b=$((16#${hex:5:2}))
    echo "$r $g $b"
}

# rgb_values=$(hex_to_rgb "$1")
# echo "$rgb_values"
# while read -r hex_color; do
#     rgb_values=$(hex_to_rgb "$hex_color")
#     echo "Hex: $hex_color, RGB: $rgb_values"
# done

while read -r line; do
    # Extract the hex color from each line
    hex_color=$(echo "$line" | grep -o '#[0-9A-Fa-f]\{6\}')
    if [ -n "$hex_color" ]; then
        rgb_values=$(hex_to_rgb "$hex_color")
        echo "$rgb_values"
    else
        # If no hex color found, echo the entire line
        echo "$line"
    fi
done
