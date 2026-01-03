#!/bin/sh

# Usage: timer.sh <seconds>

# if [ -z "$1" ] || ![[ "$1" =~ ^[0-9]+$ ]]; then
#         echo "Usage: $1 <seconds>"
#         exit 1
# fi

(
        total="$1"
        remaining="$total"

        notif_id=$(notify-send -p -u low \
                "$(printf "%02d:%02d" $((remaining/60)) $((remaining%60)))" \
                2>/dev/null)

        while [ "$remaining" -gt 0 ]; do
                sleep 1
                remaining=$((remaining - 1))

                notify-send -r "$notif_id" -u low \
                        "$(printf "%02d:%02d" $((remaining/60)) $((remaining%60)))" \
                        2>/dev/null
                done

                notify-send -r "$notif_id" -u critical -t 3000 \
                        -li "" "Timer finished after $total seconds!" \
                        2>/dev/null

                paplay "$HOME/dotfiles/sounds/dunst-1.wav" 2>/dev/null
                ) &
