#!/bin/bash
set -u
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

link() { 
    if [ ! -e "$2" -a ! -L "$2" ]
    then
        ln -s "$1" "$2"
    fi
}
echo "Installing .config"
mkdir -p "$HOME/.config"
for dir in $SCRIPT_DIR/*/; do
    basename=$(basename $dir)
    echo "  - $basename"
    link "$dir" "$HOME/.config/$basename"
done