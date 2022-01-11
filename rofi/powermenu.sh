#!/bin/env bash

lock="  Lock"
sleep="鈴  Sleep"
hibernate="  Hibernate"
restart="勒  Restart"
shutdown="  Shutdown"
logout="  Logout"

options="$lock\n$sleep\n$hibernate\n$restart\n$shutdown\n$logout"

chosen="$(echo -e "$options" | rofi -dmenu -i -l 6 -selected-row 0 -theme ~/.config/rofi/themes/picker.rasi)"

case $chosen in
  $lock)
    lock
    ;;
  $sleep)
    systemctl suspend
    ;;
  $hibernate)
    systemctl hibernate
    ;;
  $restart)
    systemctl reboot
    ;;
  $shutdown)
    systemctl poweroff
    ;;
  $logout)
    bspc quit
    ;;
esac
