#!/bin/bash
set -u
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

echo "Installing applications and settings"
for dir in $SCRIPT_DIR/*/; do
    basename=$(basename $dir)
    echo "  - $basename"
    "$dir/install.sh"
done