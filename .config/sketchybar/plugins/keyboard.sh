#!/usr/bin/env bash
SOURCE=$(defaults read ~/Library/Preferences/com.apple.HIToolbox.plist AppleCurrentKeyboardLayoutInputSourceID)

case ${SOURCE} in
'com.apple.keylayout.Swedish-Pro') LABEL='sv' ;;
'org.unknown.keylayout.Swerty') LABEL='swerty' ;;
esac

sketchybar --set $NAME icon="􀇳" label="$LABEL"