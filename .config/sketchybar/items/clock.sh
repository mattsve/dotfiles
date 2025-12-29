#!/usr/bin/env bash

items+=(
    --add item clock $POSITION
    --set clock update_freq=10 icon.drawing=off script="$PLUGIN_DIR/clock.sh"
)
