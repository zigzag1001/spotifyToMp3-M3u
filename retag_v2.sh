#!/bin/bash

# looks wierd becuase was supposed to use null character as delimiter but it dont work with mp3

cd ../mp3

# Function to get first artist
get_first_artist() {
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

# Loop through all and .mp3 files in the current directory
for file in *.mp3; do
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
        new_artist=$(get_first_artist "$current_artist")
        new_album_artist=$(get_first_artist "$album_artist")

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

