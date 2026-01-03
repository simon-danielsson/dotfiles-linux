#!/bin/bash
COLOR=$(xcolor --format hex)
echo -n "$COLOR" | xclip -selection clipboard
notify-send "  $COLOR has been copied to clipboard!"


