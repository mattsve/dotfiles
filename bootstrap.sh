#!/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

link() { 
    if [ ! -e "$2" -a ! -L "$2" ]
    then
        ln -s "$1" "$2"
    fi
}

mkdir -p "$HOME/bin"
mkdir -p "$HOME/.cache"

if [ ! -f "$HOME/bin/oh-my-posh" ]
then
    echo "Downloading oh-my-posh"
    curl -# -L --fail https://github.com/JanDeDobbeleer/oh-my-posh/releases/latest/download/posh-linux-$(uname -m | sed s/x86_64/amd64/) -o "$HOME/bin/oh-my-posh"
    chmod +x "$HOME/bin/oh-my-posh"
fi

link "$SCRIPT_DIR/poshthemes" "$HOME/.poshthemes"

grep -qxF ". '$SCRIPT_DIR/bash/bashrc'" "$HOME/.bashrc" || echo ". '$SCRIPT_DIR/bash/bashrc'" >> "$HOME/.bashrc"