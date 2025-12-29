#!/usr/bin/env bash
# https://github.com/anatoli-tsinovoy/dotfiles

items+=(
    --add event aerospace_workspace_change
    --add event aerospace_focus_change
    --add event aerospace_monitor_move
    --add event aerospace_node_moved
    --add event aerospace_window_detected
)
while read -r ws; do
    item=(
        icon="$ws"
        icon.font="SF Pro:Regular:14.0"
        label.font="sketchybar-app-font:Regular:14"
        icon.highlight_color=$ACCENT_COLOR
        background.drawing=on
        background.color=$BAR_COLOR
        background.border_color=$ACCENT_COLOR
        background.border_width=0
    )
    items+=(
        --add item space.$ws $POSITION
        --set space.$ws "${item[@]}"
    )
done < <(aerospace list-workspaces --all --format '%{workspace}')

items+=(
    --add item as_ws_changer $POSITION
    --set as_ws_changer script="$PLUGIN_DIR/aerospace.sh" drawing=off updates=on
    --subscribe as_ws_changer aerospace_workspace_change
    --subscribe as_ws_changer aerospace_focus_change
    --subscribe as_ws_changer aerospace_monitor_move
    --subscribe as_ws_changer aerospace_node_moved
    --subscribe as_ws_changer aerospace_window_detected
)