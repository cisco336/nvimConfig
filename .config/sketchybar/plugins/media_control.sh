#!/usr/bin/env bash

# make sure it's executable with:
# chmod +x ~/.config/sketchybar/plugins/media_control.sh

DATA="$(media-control get -h 2>/dev/null)"

PLAYING="$(echo "$DATA" | jq -r '.playing')"
MEDIA="$(echo "$DATA" | jq -r '.title + " - " + .artist')"

echo "$MEDIA"

if [ "$PLAYING" = "true" ]; then
	sketchybar --set "$NAME" label="$MEDIA" drawing=on icon="⏸"
else
	sketchybar --set "$NAME" label="$MEDIA" drawing=on icon="▶"
fi
