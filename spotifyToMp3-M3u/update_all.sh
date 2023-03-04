# Run a Python script and store its output as JSON
json=$(python3 main.py)

# Change the current directory to the "mp3" folder
cd ../mp3

# Extract each key-value pair from the JSON string, separated by "|", and iterate through them
jq -r 'to_entries | map(.key + "|" + (.value | tostring)) | .[]' <<<"$json" | \
  while IFS='|' read key value; do
    # Print the current key being processed
    echo $key
    # Use spotdl to download the audio file for the current value (a Spotify URL) and save it as a .m3u file with the current key as the filename
    python3.11 -m spotdl $value --m3u "${key}.m3u"
  done

# Reverse the order of each .m3u file's contents
for file in *.m3u; do tac "$file" > tmp && mv tmp "$file"; done
