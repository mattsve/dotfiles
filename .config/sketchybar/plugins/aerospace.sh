#!/usr/bin/env bash
read -a as_to_sb <<<"$(sketchybar --query display_change | jq -r '.label.value')"
args=()

function update_applications() {
  current_number_of_windows="$(aerospace list-windows --all | wc -l)"
  previous_number_of_windows="$(sketchybar --query as_ws_changer | jq -r '.label.value')"
  sketchybar --set as_ws_changer label="$current_number_of_windows"
  
  if [[ ${1:-false} = "false" && "$current_number_of_windows" = "$previous_number_of_windows" ]]; then
    return
  fi

  while read -r ws visible focused; do
    apps=()
    IFS=$'\n' read -d '' -r -a apps < <(aerospace list-windows --workspace "$ws" --format '%{app-name}')
    if [[ "$visible" = "true" || "$focused" = "true" || ${#apps[@]} -gt 0 ]]; then drawing="on"; else drawing="off"; fi
    if [[ ${#apps[@]} -gt 0 ]]; then
      label="$($CONFIG_DIR/plugins/icon_map.sh "${apps[@]}")"
    else
      label=""
    fi
    args+=(
      --set space.$ws label="$label" drawing=$drawing
    )
  done < <(aerospace list-workspaces --all --format '%{workspace} %{workspace-is-visible} %{workspace-is-focused}')
}

function update_display() {
  while read -r ws monitor; do
    display=${as_to_sb[(($monitor - 1))]}
    args+=(
      --set space.$ws display="$display"
    )
  done < <(aerospace list-workspaces --all --format '%{workspace} %{monitor-id}')
}

function update_workspace_focus() {
  args+=(
    --set space.$FOCUSED_WORKSPACE icon.highlight=on background.border_width=2 drawing=on
  )
  if [ ! -z ${PREV_WORKSPACE+x} ]; then
    args+=(
      --set space.$PREV_WORKSPACE icon.highlight=off background.border_width=0
    )
    prev_visible=$(aerospace list-windows --workspace $PREV_WORKSPACE --format 'true' | head -n1)
    if [ "${prev_visible:-false}" = "false" ]; then
      args+=(
        --set space.$PREV_WORKSPACE label="" drawing=off
      )
    fi
  fi
}

if [[ "$SENDER" = "forced" ]]; then
  FOCUSED_WORKSPACE="$(aerospace list-workspaces --focused)"
  update_applications
  update_display
  update_workspace_focus
fi

if [[ "$SENDER" = "aerospace_node_moved" || "$SENDER" = "aerospace_window_detected" ]]; then
  update_applications "true"
fi

if [[ "$SENDER" = "aerospace_monitor_move" ]]; then
  update_display
fi

if [[ "$SENDER" = "aerospace_workspace_change" ]]; then
  update_workspace_focus
fi

if [[ "$SENDER" = "aerospace_focus_change" ]]; then
  update_applications
fi

if [ ${#args[@]} -gt 0 ]; then
  sketchybar "${args[@]}"
fi