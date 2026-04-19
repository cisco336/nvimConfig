#!/bin/bash

# Usage: ./convertmp.sh

convertmp() {
    # Check if ffmpeg is installed
    if ! command -v ffmpeg &> /dev/null; then
        echo "ffmpeg could not be found. Please install ffmpeg to use this script."
        return 1
    fi

    INPUT_DIR="$(pwd)"

    for file in "$INPUT_DIR"/*; do
      [ -f "$file" ] || continue

      # Check if file is a video
      mimetype=$(file --mime-type -b "$file")
      if [[ "$mimetype" == video/* ]]; then
        filename=$(basename "$file")
        name="${filename%.*}"
        output="$INPUT_DIR/$name.mp4"
        ffmpeg -i "$file" "$output"
      else
        echo "Skipping $file (not a video file)"
      fi
    done
}