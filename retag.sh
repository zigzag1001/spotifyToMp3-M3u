#!/bin/bash

cd ../mp3

processed_file="processed_files.txt"

# Loop through mp3 files with spaces and special characters handled
find . -name "*.mp3" -print0 | while IFS= read -r -d '' file; do
    filename=$(basename "$file")

    if ! grep -qFx "$filename" "$processed_file"; then
        main_artist=$(eyeD3 "$file" | grep "^artist:" | cut -d ':' -f 2 | cut -d '/' -f 1 | xargs)
        eyeD3 --artist="$main_artist" "$file"
        echo "$filename" >> "$processed_file"
    fi
done
