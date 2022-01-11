#!/bin/env bash

now="  Desktop"
win="类  Window"
area="麗  Selection"

options="$now\n$win\n$area"

chosen="$(echo -e "$options" | rofi -dmenu -i -l 3 -selected-row 0 -theme ~/.config/rofi/themes/picker.rasi)"

case $chosen in
  $now)
    takeshot --now
    ;;
  $win)
    takeshot --win
    ;;
  $area)
    flameshot gui -p ~/Pictures/Screenshots
    ;;
esac
