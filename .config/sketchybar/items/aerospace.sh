#!/usr/bin/env bash
# https://github.com/anatoli-tsinovoy/dotfiles

read -a AS_TO_SB <<<"$(sketchybar --query display_change | jq -r '.label.value')"
AEROSPACE_FOCUSED_WS=$(aerospace list-workspaces --focused)
ALL_AS_WS_AS_MON=$(aerospace list-workspaces --all --format '%{workspace} %{monitor-id}')

items+=(
    --add event aerospace_workspace_change
    --add event aerospace_focus_change
    --add event aerospace_monitor_move
)
while read -r i as_monitor; do
    sb_monitor=${AS_TO_SB[(($as_monitor - 1))]}
    sid=$i
    items+=(
        --add item space.$sid $POSITION
        --set space.$sid label="$sid" display="$sb_monitor" script="$PLUGIN_DIR/aerospace.sh"
        --subscribe space.$sid aerospace_workspace_change
    )
    if [ $sid = $AEROSPACE_FOCUSED_WS ]; then
        items+=(
            --set space.$sid label.color=$ACCENT_COLOR
        )
    fi
done <<<"${ALL_AS_WS_AS_MON}"
