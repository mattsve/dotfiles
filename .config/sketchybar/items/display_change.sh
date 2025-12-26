#!/usr/bin/env bash
# https://github.com/anatoli-tsinovoy/dotfiles
source "$PLUGIN_DIR/map_monitors.sh"
# Invisible watcher that stores the current connected displays state in its label.
# Create the invisible item and attach the plugin script
# TODO: There's actually no NSDistributedNotificationCenter notification for monitor changes, this is  all moot

sketchybar --add event display_changed \
           --add item display_change left \
           --set display_change script="$PLUGIN_DIR/display_change.sh" display=0 updates=on label="$(map_monitors)" \
	       --subscribe display_change display_changed
