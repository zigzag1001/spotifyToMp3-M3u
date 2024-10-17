json=$(python3 main.py)
cd ../mp3

# echo "Syncing Discover Weekly..."
# spotdl sync discover-weekly.sync.spotdl --m3u

jq -r 'to_entries | map(.key + "|" + (.value | tostring)) | .[]' <<<"$json" | \
  while IFS='|' read key value; do
    echo $key
    spotdl $value --m3u "$key"
  done

for file in *.m3u8; do tac "$file" > tmp && mv -f tmp "$file"; done

cd ../stuff
time bash retag_v2.sh
echo "^^^ Retagging..."
time bash 320_m3u8.sh
echo "^^^ >320 playlist"
python3.11 get_dupes.py ../mp3
