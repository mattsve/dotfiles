#!/bin/bash
set -euo pipefail
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

echo "Applying settings"
for dir in "$SCRIPT_DIR"/*/; do
    dir_name=$(basename "$dir")
    if [[ -x "$dir/install.sh" ]]; then
        echo "  - $dir_name"
        "$dir/install.sh"
    fi
done
