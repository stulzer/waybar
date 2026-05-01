#!/bin/bash
set -euo pipefail

MON_CONF="$HOME/.config/hypr/monitors.conf"
ENABLED_LINE="monitor = eDP-1, 1920x1080@360, 0x290, 1"
DISABLED_LINE="monitor = eDP-1, disabled"

is_disabled() {
  grep -qx "$DISABLED_LINE" "$MON_CONF"
}

case "${1:-}" in
status)
  if is_disabled; then
    echo '{"text":"󰌢"}'
  else
    echo '{"text":"󰛧"}'
  fi
  ;;
toggle)
  if is_disabled; then
    printf '%s\n' "$ENABLED_LINE" > "$MON_CONF"
    hyprctl keyword monitor "eDP-1, 1920x1080@360, 0x290, 1" >/dev/null
  else
    printf '%s\n' "$DISABLED_LINE" > "$MON_CONF"
    hyprctl keyword monitor "eDP-1, disabled" >/dev/null
  fi
  pkill -RTMIN+8 waybar 2>/dev/null || true
  ;;
esac
