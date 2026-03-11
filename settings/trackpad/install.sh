#!/bin/bash
set -euo pipefail

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
if [[ "$(defaults read com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadFourFingerVertSwipeGesture 2>/dev/null)" != "2" ]]; then
    defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadFourFingerVertSwipeGesture -int 2
    echo "  [BT] Set four finger vertical swipe gesture"
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
if [[ "$(defaults -currentHost read NSGlobalDomain com.apple.trackpad.fourFingerVertSwipeGesture 2>/dev/null)" != "2" ]]; then
    defaults -currentHost write NSGlobalDomain com.apple.trackpad.fourFingerVertSwipeGesture -int 2
    echo "  [currentHost] Set four finger vertical swipe gesture"
fi
