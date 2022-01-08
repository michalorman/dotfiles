#!/bin/env bash

declare -A links=(
["npm"]="npmjs.com"
["Rust Book"]="doc.rust-lang.org/stable/book"
)

choice=$(printf '%s\n' "${!links[@]}" | sort -u | rofi -dmenu -p " " -i -selected-row 0 -theme ~/.config/rofi/picker-search.rasi)

if [ "$choice" ]; then
    xdg-open "https://${links[$choice]}"
else
    exit 1
fi
