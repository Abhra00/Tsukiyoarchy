#!/usr/bin/env bash
#  ┓ ┏┏┓┓┏┳┓┏┓┳┓  ┓ ┏┓┳┳┳┓┏┓┓┏
#  ┃┃┃┣┫┗┫┣┫┣┫┣┫━━┃ ┣┫┃┃┃┃┃ ┣┫
#  ┗┻┛┛┗┗┛┻┛┛┗┛┗  ┗┛┛┗┗┛┛┗┗┛┛┗
#

source "$HOME"/.config/waybar/colors.env
envsubst <~/.config/waybar/config.jsonc | setsid uwsm app -- waybar -c /dev/stdin &
