#!/bin/bash

# Loop through all .flac files in the current directory
for file in *.flac; do
  # Extract the base name of the file without the extension
  base_name="${file%.*}"
  
  # Convert the .flac file to .mp3 with 320 kbps while preserving metadata
  ffmpeg -i "$file" -ab 320k -map_metadata 0 "${base_name}.mp3"
done

echo "Conversion complete."

