#!/usr/bin/env bash

if [[ $(scutil --nc list | grep -c -e Connected -e Connecting) -gt 0 ]]; then
  sketchybar --set "$NAME" drawing=on
else
  sketchybar --set "$NAME" drawing=off
fi
