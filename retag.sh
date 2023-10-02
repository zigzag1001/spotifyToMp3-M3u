#!/bin/bash

# Change to the directory containing the mp3 files
cd ../mp3

processed_file="processed_files.txt"

# Loop through the entries in processed_files.txt
while read -r filename; do
    # If a file does not exist, remove the entry from processed_files.txt
    if [[ ! -f $filename ]]; then
        echo "Removing $filename from $processed_file"
        sed -i "/$filename/d" "$processed_file"
    fi
done < "$processed_file"

# Loop through the mp3 files in the directory
find . -name "*.mp3" -print0 | while IFS= read -r -d '' file; do
    filename=$(basename "$file")

    # If the file is not present in processed_files.txt, retag it
    if ! grep -qFx "$filename" "$processed_file"; then
        main_artist=$(eyeD3 "$file" | sed -n 's/^artist: \(.*\)/\1/p' | cut -d '/' -f 1)
        eyeD3 --artist="$main_artist" "$file"
        echo "$filename" >> "$processed_file"
    fi
done
