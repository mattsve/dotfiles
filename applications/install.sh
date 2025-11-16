#!/bin/bash
set -u
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

echo "Installing applications and settings"
for dir in $SCRIPT_DIR/*/; do
    basename=$(basename $dir)
    echo "  - $basename"
    "$dir/install.sh"
done

echo "Settings from 1password"
op item list --vault Settings --format=json | jq -c '.[]' | while read -r item; do
    echo "  - $(echo "$item" | jq -r '.title')"
    details=$(op item get "$(echo "$item" | jq -r '.id')" --vault "$(echo "$item" | jq -r '.vault.id')" --format=json)
    dir="$(echo "$details" | jq -r '.fields[] | select(.label == "path") | .value')"
    dir="${dir/#\~/$HOME}" 
    mkdir -p "${dir}"
    echo "$details" | jq -c '.files[]' | while read -r file; do
        path="$dir/$(echo "$file" | jq -r '.name')"
        if [[ ! -f "${path}" ]]; then
            op read "op://$(echo "$details" | jq -r '.vault.id')/$(echo "$details" | jq -r '.id')/$(echo "$file " | jq -r '.id')" > "${path}"
        fi
    done
done