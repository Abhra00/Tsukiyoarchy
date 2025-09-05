#!/usr/bin/env bash
#  ┏┓┏┓┏┳┓  ┳┳┓┏┓┳┓  ┏┓┏┓┓┏┏┓┳┓
#  ┃┓┣  ┃ ━━┃┃┃┃┃┃┃━━┃ ┃┃┃┃┣ ┣┫
#  ┗┛┗┛ ┻   ┛ ┗┣┛┻┛  ┗┛┗┛┗┛┗┛┛┗
#

Cover=/tmp/rofi_cover.png
bkpCover="$HOME"/Music/covers/fallback.webp
mpddir="$HOME"/Music

ffmpeg -i "$mpddir/$(mpc current -f %file%)" \
    "$Cover" -y >/dev/null 2>&1 ||
    cp "$bkpCover" "$Cover"
