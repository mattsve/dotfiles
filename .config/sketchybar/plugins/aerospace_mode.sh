#!/usr/bin/env bash

mode="$(aerospace list-modes --current | tr '[:lower:]' '[:upper:]')"
label="[${mode:0:1}]"

if [ "$mode" = "MAIN" ]; then
  sketchybar --set $NAME label="$label" drawing=off
else
    sketchybar --set $NAME label="$label" drawing=on
fi
