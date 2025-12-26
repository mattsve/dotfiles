#!/usr/bin/env bash

items+=(
    --add item keyboard $POSITION
    --add event input_change 'AppleSelectedInputSourcesChangedNotification'
    --set keyboard script="$PLUGIN_DIR/keyboard.sh"
    --subscribe keyboard input_change
)
