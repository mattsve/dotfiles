#!/usr/bin/env bash
# https://github.com/anatoli-tsinovoy/dotfiles
source "$CONFIG_DIR/plugins/map_monitors.sh"
current_displays="$(map_monitors)"
previous_displays="$(sketchybar --query display_change | jq -r '.label.value')"
sketchybar --set display_change label="$current_displays" display=0

if [ "$SENDER" != "forced" ] && [ "$previous_displays" != "$current_displays" ]; then
  # sketchybar --reload # for some odd reason this increments the number of bars in play on every theme change
  # Note that this has a 10-second back-off time set by the crash-loop detection in sketchybar's plist, so fast-toggling is off the table
  launchctl kickstart -kp "gui/$UID/homebrew.mxcl.sketchybar"
fi