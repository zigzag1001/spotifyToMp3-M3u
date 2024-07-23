#!/bin/bash

# cd ../mp3

# Function to process artists
process_artists() {
    local artists="$1"
    # Replace "/" with ", "
    artists="${artists//\//, }"
    # Replace ";" with ", "
    artists="${artists//;/, }"
    echo "$artists"
}

# Function to process album artists
# Only first artist is used
process_album_artists() {
    local artists="$1"
    # Replace "/" with ", "
    artists="${artists//\//, }"
    # Replace ";" with ", "
    artists="${artists//;/, }"
    # Get the first artist
    artists=$(echo "$artists" | cut -d "," -f1)
    echo "$artists"
}

# File to keep track of processed files
PROCESSED_FILES="processed_files.txt"

# Create the processed_files.txt if it doesn't exist
touch "$PROCESSED_FILES"

# Loop through all .flac and .mp3 files in the current directory
for file in *.flac *.mp3; do
    # Check if file exists (to handle cases where there are no matching files)
    if [[ -f "$file" ]]; then
        # Skip the file if it is already listed in processed_files.txt
        if grep -Fxq "$file" "$PROCESSED_FILES"; then
            # echo "Skipping already processed file: $file"
            continue
        fi

        echo "Processing $file"

        # Get current artist tag
        current_artist=$(eyeD3 --no-color "$file" | grep -i "^artist:" | sed 's/^.*: //')
        album_artist=$(eyeD3 --no-color "$file" | grep -i "^album artist:" | sed 's/^.*: //')

        # Process the artists
        new_artist=$(process_artists "$current_artist")
        new_album_artist=$(process_album_artists "$album_artist")

        # Update the artist tag if it has changed
        if [[ "$current_artist" != "$new_artist" ]]; then
            eyeD3 --artist="$new_artist" "$file"
            eyeD3 --album-artist="$new_album_artist" "$file"
            echo "Updated artist for $file: $new_artist"
            # Add the file to processed_files.txt
            echo "$file" >> "$PROCESSED_FILES"
        else
            echo "No change needed for $file"
            echo "$file" >> "$PROCESSED_FILES"
        fi
    fi
done

echo "Processing complete."

