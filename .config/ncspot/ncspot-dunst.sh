#!/bin/bash

PLAYER_NAME="ncspot"
TMPDIR="/tmp/ncspot-art"
mkdir -p "$TMPDIR"

# Kill any old instances of this script first
pkill -f "playerctl -p $PLAYER_NAME metadata --follow"

playerctl -p "$PLAYER_NAME" metadata --follow | while read -r _; do
    # 1. Ultra-low delay for a fast machine
    sleep 0.1
    
    # 2. Grab metadata
    title=$(playerctl -p "$PLAYER_NAME" metadata title)
    artist=$(playerctl -p "$PLAYER_NAME" metadata artist)
    art_url=$(playerctl -p "$PLAYER_NAME" metadata mpris:artUrl)
    
    # 3. Cache-Buster: Create a unique filename for this song
    # We use the song title to make sure Dunst sees a "new" file every time
    clean_name=$(echo "$title" | tr -d '[:space:]' | tr -dc '[:alnum:]')
    art_file="$TMPDIR/${clean_name}.jpg"

    # 4. Grab the Art
    if [[ $art_url == file://* ]]; then
        cp "${art_url#file://}" "$art_file"
    elif [[ -n $art_url ]]; then
        curl -sL "$art_url" -o "$art_file"
    fi

    # 5. Notify with the stack-tag to prevent segments/flicker
    notify-send -i "$art_file" "Now Playing" "<b>$title</b>\n$artist" \
        -h string:x-dunst-stack-tag:music \
        -h string:x-canonical-private-synchronous:music

    # 6. Cleanup (Optional: deletes old covers so /tmp doesn't get cluttered)
    find "$TMPDIR" -name "*.jpg" ! -name "${clean_name}.jpg" -delete 2>/dev/null
done
