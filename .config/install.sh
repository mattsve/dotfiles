#!/bin/bash
set -euo pipefail
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

link() {
    if [[ ! -e "$2" && ! -L "$2" ]]; then
        ln -s "$1" "$2"
    fi
}

echo "Installing .config"
mkdir -p "$HOME/.config"
for dir in "$SCRIPT_DIR"/*/; do
    dir_name=$(basename "$dir")
    echo "  - $dir_name"
    link "$dir" "$HOME/.config/$dir_name"
done
