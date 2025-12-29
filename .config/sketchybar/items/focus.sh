#!/usr/bin/env bash

items+=(
    --add item focus $POSITION
    --set focus label.drawing=off script="$PLUGIN_DIR/focus.sh"
    --add event focus_on "_NSDoNotDisturbEnabledNotification"
	--add event focus_off "_NSDoNotDisturbDisabledNotification"
    --subscribe focus focus_on focus_off
)
