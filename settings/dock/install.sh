#!/bin/bash
set -euo pipefail

KILL_DOCK=false
if [[ "$(defaults read com.apple.dock persistent-apps 2>/dev/null)" != "(
)" ]]; then
    defaults write com.apple.dock persistent-apps -array
    echo "  Cleared persistent apps"
    KILL_DOCK=true
fi
if [[ "$(defaults read com.apple.dock appswitcher-all-displays 2>/dev/null)" != "1" ]]; then
    defaults write com.apple.dock appswitcher-all-displays -bool true
    echo "  Enabled app switcher on all displays"
    KILL_DOCK=true
fi
if [[ "$(defaults read com.apple.dock show-recents 2>/dev/null)" != "0" ]]; then
    defaults write com.apple.dock show-recents -bool false
    echo "  Disabled recent applications"
    KILL_DOCK=true
fi
if [[ "$(defaults read com.apple.dock expose-group-apps 2>/dev/null)" != "1" ]]; then
    defaults write com.apple.dock expose-group-apps -bool true
    echo "  Enabled grouping of windows in app exposé"
    KILL_DOCK=true
fi
if [[ "$(defaults read com.apple.dock orientation 2>/dev/null)" != "left" ]]; then
    defaults write com.apple.dock orientation left
    echo "  Moved dock to the left"
    KILL_DOCK=true
fi

if $KILL_DOCK; then
    killall Dock
fi
