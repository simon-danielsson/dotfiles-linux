#!/usr/bin/env bash

INPUT_DIR="~/autodirs/image-to-comp-webp/"
mkdir -p "$INPUT_DIR"

OUTPUT_DIR="$INPUT_DIR/webp"
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

