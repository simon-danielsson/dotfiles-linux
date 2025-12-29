#!/bin/sh

# One-shot 30 second timer

total=30
remaining=$total

notif_id=$(notify-send -p -u low \
        " Timer" \
        "$(printf "%02d:%02d" $((remaining/60)) $((remaining%60)))" \
        2>/dev/null)

while [ "$remaining" -gt 0 ]; do
        sleep 1
        remaining=$((remaining - 1))

        notify-send -r "$notif_id" -u low \
                " Timer" \
                "$(printf "%02d:%02d" $((remaining/60)) $((remaining%60)))" \
                2>/dev/null
        done

        notify-send -r "$notif_id" -u critical -t 3000 \
                " Timer finished!" \
                "30 seconds elapsed!" \
                2>/dev/null

        paplay "$HOME/dotfiles/sounds/dunst-1.wav" 2>/dev/null
