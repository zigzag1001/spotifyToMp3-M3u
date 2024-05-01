cd ../mp3

exiftool -if '$AudioBitrate eq "320 kbps"' -filename -s -s -s ./ \
| sed -e '/^==.*/d' -e '/^Turbo/d' \
| head -n -3 \
> 320.m3u8

ls *.wav -N -w 1 -1 >> 320.m3u8
