#!/usr/bin/env bash

items+=(
    --add item clock $POSITION
    --set clock update_freq=10 script="$PLUGIN_DIR/clock.sh"
)
