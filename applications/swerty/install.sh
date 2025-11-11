#!/bin/bash
set -u
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

if [[ "$(uname)" == "Darwin" ]]; then
    for file in "${SCRIPT_DIR}/darwin/"*; do
        if [[ -f "$file" ]]; then
            basename=$(basename $file)
            target="${HOME}/Library/Keyboard Layouts/$basename"
            if [[ ! -e "$target" ]] || [[ "$(shasum -a 256 "$file" | cut -d ' ' -f 1)" != "$(shasum -a 256 "$target" | cut -d ' ' -f 1)" ]]; then
                cp "$file" "$target"
            fi
        fi
    done
fi
