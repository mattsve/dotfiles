#!/bin/bash
set -euo pipefail

if ! command -v brew &> /dev/null; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    echo >> ~/.zprofile
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
fi

if [[ ! -d "${HOME}/.dotfiles/" ]]; then
    /opt/homebrew/bin/brew install --cask 1password
    echo "Set up 1password and enable ssh agent"
    read -rp "Press enter to continue"
    git clone git@github.com:mattsve/dotfiles.git ~/.dotfiles

    echo "Run this command to add Homebrew to your PATH:"
    echo '    eval "$(/opt/homebrew/bin/brew shellenv)"'
    echo "Run this command to bootstrap the machine"
    echo '    ~/.dotfiles/darwin/install.sh'
    exit 0
fi

echo "Setting up sudo to use touch id"
if [[ ! -f "/etc/pam.d/sudo_local" ]]; then
    sed -e 's/^#auth/auth/' /etc/pam.d/sudo_local.template | sudo tee /etc/pam.d/sudo_local
fi

echo "Setting up rosetta"
if [[ ! -f "/Library/Apple/usr/libexec/oah/libRosettaRuntime" ]]; then
    softwareupdate --install-rosetta --agree-to-license
fi

echo "Installing brew packages"
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
brew bundle install --file "${SCRIPT_DIR}/Brewfile"

"${SCRIPT_DIR}/../.config/install.sh"
"${SCRIPT_DIR}/../applications/install.sh"

echo "Setting up dock"
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

echo "Setting up trackpad"
if [[ "$(defaults read com.apple.AppleMultitouchTrackpad DragLock 2>/dev/null)" != "0" ]]; then
    defaults write com.apple.AppleMultitouchTrackpad DragLock -bool false
    echo "  Disabled drag lock"
fi
if [[ "$(defaults read com.apple.AppleMultitouchTrackpad Dragging 2>/dev/null)" != "0" ]]; then
    defaults write com.apple.AppleMultitouchTrackpad Dragging -bool false
    echo "  Disabled dragging"
fi
if [[ "$(defaults read com.apple.AppleMultitouchTrackpad Clicking 2>/dev/null)" != "1" ]]; then
    defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true
    echo "  Enabled clicking"
fi
if [[ "$(defaults read com.apple.AppleMultitouchTrackpad TrackpadThreeFingerDrag 2>/dev/null)" != "1" ]]; then
    defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerDrag -bool true
    echo "  Enabled three finger drag"
fi
if [[ "$(defaults read com.apple.AppleMultitouchTrackpad TrackpadFourFingerHorizSwipeGesture 2>/dev/null)" != "2" ]]; then
    defaults write com.apple.AppleMultitouchTrackpad TrackpadFourFingerHorizSwipeGesture -int 2
    echo "  Set four finger horizontal swipe gesture"
fi
if [[ "$(defaults read com.apple.AppleMultitouchTrackpad TrackpadFourFingerPinchGesture 2>/dev/null)" != "2" ]]; then
    defaults write com.apple.AppleMultitouchTrackpad TrackpadFourFingerPinchGesture -int 2
    echo "  Set four finger pinch gesture"
fi
if [[ "$(defaults read com.apple.AppleMultitouchTrackpad TrackpadFourFingerVertSwipeGesture 2>/dev/null)" != "2" ]]; then
    defaults write com.apple.AppleMultitouchTrackpad TrackpadFourFingerVertSwipeGesture -int 2
    echo "  Set four finger vertical swipe gesture"
fi
if [[ "$(defaults read com.apple.AppleMultitouchTrackpad TrackpadThreeFingerHorizSwipeGesture 2>/dev/null)" != "0" ]]; then
    defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerHorizSwipeGesture -int 0
    echo "  Disabled three finger horizontal swipe gesture"
fi
if [[ "$(defaults read com.apple.AppleMultitouchTrackpad TrackpadThreeFingerTapGesture 2>/dev/null)" != "0" ]]; then
    defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerTapGesture -int 0
    echo "  Disabled three finger tap gesture"
fi
if [[ "$(defaults read com.apple.AppleMultitouchTrackpad TrackpadThreeFingerVertSwipeGesture 2>/dev/null)" != "0" ]]; then
    defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerVertSwipeGesture -int 0
    echo "  Disabled three finger vertical swipe gesture"
fi
if [[ "$(defaults read com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking 2>/dev/null)" != "1" ]]; then
    defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
    echo "  [BT] Enabled clicking"
fi
if [[ "$(defaults read com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerDrag 2>/dev/null)" != "1" ]]; then
    defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerDrag -bool true
    echo "  [BT] Enabled three finger drag"
fi
if [[ "$(defaults read com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerHorizSwipeGesture 2>/dev/null)" != "0" ]]; then
    defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerHorizSwipeGesture -int 0
    echo "  [BT] Disabled three finger horizontal swipe gesture"
fi
if [[ "$(defaults read com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerTapGesture 2>/dev/null)" != "0" ]]; then
    defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerTapGesture -int 0
    echo "  [BT] Disabled three finger tap gesture"
fi
if [[ "$(defaults read com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerVertSwipeGesture 2>/dev/null)" != "0" ]]; then
    defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerVertSwipeGesture -int 0
    echo "  [BT] Disabled three finger vertical swipe gesture"
fi
if [[ "$(defaults -currentHost read NSGlobalDomain com.apple.mouse.tapBehavior 2>/dev/null)" != "1" ]]; then
    defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
    echo "  [currentHost] Enabled tap to click"
fi
if [[ "$(defaults -currentHost read NSGlobalDomain com.apple.trackpad.threeFingerDragGesture 2>/dev/null)" != "1" ]]; then
    defaults -currentHost write NSGlobalDomain com.apple.trackpad.threeFingerDragGesture -bool true
    echo "  [currentHost] Enabled three finger drag gesture"
fi
if [[ "$(defaults -currentHost read NSGlobalDomain com.apple.trackpad.threeFingerHorizSwipeGesture 2>/dev/null)" != "0" ]]; then
    defaults -currentHost write NSGlobalDomain com.apple.trackpad.threeFingerHorizSwipeGesture -int 0
    echo "  [currentHost] Disabled three finger horizontal swipe gesture"
fi
if [[ "$(defaults -currentHost read NSGlobalDomain com.apple.trackpad.threeFingerTapGesture 2>/dev/null)" != "0" ]]; then
    defaults -currentHost write NSGlobalDomain com.apple.trackpad.threeFingerTapGesture -int 0
    echo "  [currentHost] Disabled three finger tap gesture"
fi
if [[ "$(defaults -currentHost read NSGlobalDomain com.apple.trackpad.threeFingerVertSwipeGesture 2>/dev/null)" != "0" ]]; then
    defaults -currentHost write NSGlobalDomain com.apple.trackpad.threeFingerVertSwipeGesture -int 0
    echo "  [currentHost] Disabled three finger vertical swipe gesture"
fi

echo "Setting up appearance"
if defaults read NSGlobalDomain AppleInterfaceStyle &>/dev/null; then
    defaults delete NSGlobalDomain AppleInterfaceStyle
    echo "  Deleted AppleInterfaceStyle"
fi
if defaults read NSGlobalDomain AppleInterfaceStyleSwitchesAutomatically &>/dev/null; then
    defaults delete NSGlobalDomain AppleInterfaceStyleSwitchesAutomatically
    echo "  Deleted AppleInterfaceStyleSwitchesAutomatically"
fi

echo "Setting up services"
brew services start borders

echo "Done!"
