#!/bin/bash

HYPR_CONF="$HOME/.config/hypr/hyprland.conf"

is_disabled() {
  grep -q '^monitor = eDP-1, disabled' "$HYPR_CONF"
}

case "$1" in
status)
  if is_disabled; then
    echo '{"text":"󰌢"}'
  else
    echo '{"text":"󰛧"}'
  fi
  ;;
toggle)
  if is_disabled; then
    sed -i 's/^monitor = eDP-1, disabled/# monitor = eDP-1, disabled/' "$HYPR_CONF"
    sed -i 's/^# monitor = eDP-1, 1920x1080@360/monitor = eDP-1, 1920x1080@360/' "$HYPR_CONF"
    # hyprctl keyword monitor 'eDP-1, 1920x1080@360, auto, 1'
  else
    sed -i 's/^monitor = eDP-1, 1920x1080@360/# monitor = eDP-1, 1920x1080@360/' "$HYPR_CONF"
    sed -i 's/^# monitor = eDP-1, disabled/monitor = eDP-1, disabled/' "$HYPR_CONF"
    # hyprctl keyword monitor 'eDP-1, disabled'
  fi
  ;;
esac
