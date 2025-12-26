#!/usr/bin/env bash

items+=(
    --add item volume $POSITION
    --set volume script="$PLUGIN_DIR/volume.sh"
    --subscribe volume volume_change
)