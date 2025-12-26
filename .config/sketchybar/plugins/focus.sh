#!/usr/bin/env bash
ICON="󰤄"

MODE=$SENDER
if [ "$MODE" = "forced" ]; then
    if defaults read com.apple.controlcenter "NSStatusItem VisibleCC FocusModes" > /dev/null 2>&1; then
        MODE="focus_on"
    else
        MODE="focus_off"
    fi
fi 
if [ "$MODE" = "focus_off" ]; then
    sketchybar -m --set "$NAME" icon="$ICON" drawing=off
else
    sketchybar -m --set "$NAME" icon="$ICON" drawing=on
fi