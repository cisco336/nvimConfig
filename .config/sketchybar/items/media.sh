#!/usr/bin/env bash

sketchybar \
    --add item media right \
    --set media \
    label.color=0xaaffffff \
    label.max_chars=20 \
    scroll_texts=on \
    corner_radius=10 \
    background.color=0x20000000 \
    background.height=25 \
    background.corner_radius=10 \
    label.drawing=on \
    icon.color=0xaaffffff \
    icon.padding_right=7 \
    icon.padding_left=9 \
    icon.y_offset=2 \
    background.drawing=on \
    script="$PLUGIN_DIR/media_control.sh media-control get -h" \
    update_freq=1 \
    updates=on \
    click_script="media-control toggle-play-pause" \
    --subscribe media media_change
