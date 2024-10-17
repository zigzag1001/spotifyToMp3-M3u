import os
import sys
import eyed3
import json
# get all mp3s
# get title and artist for each mp3 from id3 tags

eyed3.log.setLevel("ERROR")

if len(sys.argv) < 2:
    dir = "."
else:
    dir = sys.argv[1]

files = os.listdir(dir)

allowed_ext = (".mp3")

files = [f for f in files if f.endswith(allowed_ext)]

artists = {}

for f in files:
    audiofile = eyed3.load(dir + "/" + f)
    if audiofile.tag is not None:
        artist = audiofile.tag.artist
        title = audiofile.tag.title
        if artist is None or title is None or "(slowed)" in title:
            continue
        if "(" in title and title.endswith(")"):
            title = title.split("(")[0].strip()
        if artist is not None and title is not None:
            if artist not in artists:
                artists[artist] = {}
            if title not in artists[artist]:
                artists[artist][title] = []
            artists[artist][title].append(f)
            # if len(artists[artist][title]) > 1:
            #     print(f"Duplicate: {json.dumps(artists[artist][title], indent=4)}")

remove = []

print("Remove:")
# get oldest file
for artist in artists:
    for title in artists[artist]:
        files = artists[artist][title]
        if len(files) > 1:
            files.sort(key=lambda x: os.path.getmtime(dir + "/" + x), reverse=True)
            for f in files[1:]:
                print("     " + f)
# print(json.dumps(artists["Orangestar"], indent=4))
