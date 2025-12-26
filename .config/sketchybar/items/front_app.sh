#!/usr/bin/env bash

items+=(
    --add item front_app $POSITION
    --set front_app icon.drawing=off script="$PLUGIN_DIR/front_app.sh"
    --subscribe front_app front_app_switched
)