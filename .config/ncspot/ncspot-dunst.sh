#!/bin/bash

PLAYER="ncspot"
TMPDIR="/tmp/ncspot-art"
mkdir -p "$TMPDIR"

while read -r _; do
    title=$(playerctl --player=$PLAYER metadata title)
    artist=$(playerctl --player=$PLAYER metadata artist)
    album=$(playerctl --player=$PLAYER metadata album)
    art_url=$(playerctl --player=$PLAYER metadata mpris:artUrl)

    # Strip URI prefix if present
    art_file="$TMPDIR/cover.jpg"
    if [[ $art_url == file://* ]]; then
        cp "${art_url#file://}" "$art_file"
    elif [[ -n $art_url ]]; then
        curl -sL "$art_url" -o "$art_file"
    fi

    # Send notification with cover art
    notify-send -i "$art_file" "🎵 $title" "$artist — $album"

done < <(playerctl --player=$PLAYER metadata --follow)

