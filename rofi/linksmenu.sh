#!/bin/env bash

declare -A links=(
["  npm"]="https://npmjs.com"
["  Rust Book"]="https://doc.rust-lang.org/stable/book"
["  Hacker News"]="https://news.ycombinator.com/"
["  Arch Linux"]="https://archlinux.org/"
["  crates.io"]="https://crates.io"
["  Nerd Fonts Cheat Sheet"]="https://www.nerdfonts.com/cheat-sheet"
["  dev.to"]="https://dev.to/"
)

choice=$(printf '%s\n' "${!links[@]}" | sort -u | rofi -dmenu -p " " -i -selected-row 0 -theme ~/.config/rofi/picker-search.rasi)

if [ "$choice" ]; then
    xdg-open "${links[$choice]}"
else
    exit 1
fi
