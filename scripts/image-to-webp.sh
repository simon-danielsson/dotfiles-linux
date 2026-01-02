#!/usr/bin/env bash

DATE=$(date +"%d-%m-%Y")
INPUT_DIR="~/autodirs/image-to-comp-webp/"

OUTPUT_DIR="$INPUT_DIR$DATE"
mkdir -p "$OUTPUT_DIR"

for img in "$INPUT_DIR"/*.{jpg,jpeg,png,bmp,tiff,JPG,JPEG,PNG}; do
        [ -e "$img" ] || continue

        filename=$(basename "$img")
        name="${filename%.*}"

        ffmpeg -y -i "$img" \
                -vf "scale=iw*0.8:ih*0.8" \
                "$OUTPUT_DIR/$name.webp"
        done

        echo "Conversion complete."
        notify-send "  All images have been been converted!" "$OUTPUT_DIR"
        paplay "$HOME/dotfiles/sounds/dunst-1.wav" 2>/dev/null

