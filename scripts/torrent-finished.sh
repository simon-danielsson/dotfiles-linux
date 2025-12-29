#!/bin/sh
# Executed by transmission

notify-send \
        -r 9999 \
        -u normal \
        -t 3000 \
        " Torrent finished" \
        "$TR_TORRENT_NAME" 2>/dev/null

paplay "$HOME/dotfiles/sounds/dunst-1.wav" 2>/dev/null &
