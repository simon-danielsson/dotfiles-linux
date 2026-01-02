#!/usr/bin/env bash

set -u  # batch-safe

# ---------------- CONFIG ----------------
DATE=$(date +"%d-%m-%Y")
INPUT_DIR="/home/simon/autodirs/normalize-audio/"
OUTPUT_DIR="$INPUT_DIR/$DATE"

TARGET_TRUE_PEAK="-1"          # dBTP
FAKE_STEREO_THRESHOLD="-70"    # dB RMS of (L - R)

LOG_FILE="$OUTPUT_DIR/processing_log.txt"
# ----------------------------------------

mkdir -p "$OUTPUT_DIR"
shopt -s nullglob

# Initialize log
{
        echo "Audio Processing Log"
        echo "===================="
        echo "Date: $(date)"
        echo "Input directory:  $INPUT_DIR"
        echo "Output directory: $OUTPUT_DIR"
        echo "Fake stereo threshold (L-R RMS): ${FAKE_STEREO_THRESHOLD} dB"
        echo "Target true peak: ${TARGET_TRUE_PEAK} dBTP"
        echo
        echo
} > "$LOG_FILE"

for infile in "$INPUT_DIR"/*.{wav,aif,aiff,flac,mp3}; do
        filename="$(basename "$infile")"
        outfile="$OUTPUT_DIR/$filename"

        echo "Processing: $filename"

        channels=$(ffprobe -v error -select_streams a:0 \
                -show_entries stream=channels \
                -of default=nw=1:nk=1 "$infile")

        downmix_filter=""
        phase_diff_db="N/A"
        classification="unknown"
        downmixed="no"
        normalization_gain="N/A"

        if [[ "$channels" -eq 2 ]]; then
                phase_diff_db=$(
                        ffmpeg -i "$infile" \
                                -filter_complex "pan=mono|c0=c0-c1,astats=metadata=1:reset=1" \
                                -f null - 2>/dev/null |
                                awk '/RMS level dB/ {print $NF}' | tail -n 1
                        )

                        if [[ -n "$phase_diff_db" ]] && \
                                echo "$phase_diff_db < $FAKE_STEREO_THRESHOLD" | bc -l | grep -q 1; then
                        classification="fake stereo"
                        downmixed="yes"
                        downmix_filter="pan=mono|c0=0.5*c0+0.5*c1,"
                        echo "  → Fake stereo detected (${phase_diff_db} dB)"
                else
                        classification="true stereo"
                        echo "  → True stereo (${phase_diff_db:-N/A} dB residual)"
                        fi

                elif [[ "$channels" -eq 1 ]]; then
                        classification="mono"
                        echo "  → Mono source"
                else
                        classification="${channels} channels"
                        echo "  → ${channels}-channel source (unchanged)"
        fi

    # Run processing AND capture loudnorm output
    loudnorm_log=$(
            ffmpeg -y -i "$infile" \
                    -af "${downmix_filter}loudnorm=TP=${TARGET_TRUE_PEAK}" \
                    "$outfile" 2>&1
            )

    # Extract applied gain
    normalization_gain=$(echo "$loudnorm_log" | awk '/Gain:/ {print $2" "$3}' | tail -n 1)

    # Append to log
    {
            echo "File:                $filename"
            echo "Channels:            $channels"
            echo "Classification:      $classification"
            echo "Phase residual:      $phase_diff_db dB"
            echo "Downmixed:           $downmixed"
            echo "Normalization gain:  ${normalization_gain:-N/A}"
            echo "Output file:         processed/$filename"
            echo "---------------------------------------------"
            echo " "
    } >> "$LOG_FILE"

echo
done

echo "All files processed."
notify-send " Audio has been processed!"
paplay "$HOME/dotfiles/sounds/dunst-1.wav" 2>/dev/null
echo "Log written to: $LOG_FILE"
