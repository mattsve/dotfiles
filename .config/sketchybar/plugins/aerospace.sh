#!/usr/bin/env bash
source "$CONFIG_DIR/colors.sh"

if [ "$SENDER" = "aerospace_workspace_change" ] || [ "$SENDER" = "aerospace_focus_change" ] || [ "$SENDER" = "aerospace_monitor_move" ]; then
  if [ "$NAME" = "space.$FOCUSED_WORKSPACE" ]; then
    sketchybar --set $NAME label.color=$ACCENT_COLOR
  else
    sketchybar --set $NAME label.color=$FG_COLOR
  fi
fi
