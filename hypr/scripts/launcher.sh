#!/usr/bin/env bash
#  ┓ ┏┓┳┳┳┓┏┓┓┏┏┓┳┓
#  ┃ ┣┫┃┃┃┃┃ ┣┫┣ ┣┫
#  ┗┛┛┗┗┛┛┗┗┛┛┗┗┛┛┗
#

# Style-theme
style_theme="$HOME/.config/rofi/launcher6.rasi"

# Run
pkill rofi || true && rofi -show drun -theme "${style_theme}" -run-command "uwsm app -- {cmd}"
