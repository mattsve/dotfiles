#!/usr/bin/env bash

items+=(
    --add event wireguard_connected
    --add event wireguard_disconnected
    --add item "vpn" $POSITION
    --set "vpn" script="$PLUGIN_DIR/vpn.sh" icon.font="sketchybar-app-font:Regular:15" icon=":wireguard:" label.drawing=off
    --subscribe "vpn" wireguard_connected wireguard_disconnected
)