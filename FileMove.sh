#!/bin/bash
INCOMING="/home/User/incoming"
MEDIA_DIR="/home/Media/Movies" # Replace with your plex media directory
for f in "$INCOMING"/*.mp4; do
[ -f "$f" ] || continue 
mv "$f" "$MEDIA_DIR/"
chown -R plex:plex "$MEDIA_DIR/$(basename "$f")"
done