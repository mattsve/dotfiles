#!/usr/bin/env bash

items+=(
    --add item aerospace_mode $POSITION
    --set aerospace_mode script="$PLUGIN_DIR/aerospace_mode.sh"
    --add event aerospace_mode_change
    --subscribe aerospace_mode aerospace_mode_change
)
