#!/usr/bin/env bash
# ┏┳┓┏┓┳┳┓┏┓┳┓┏┏┓┏┓┳┓┏┓┓┏┓┏  ┳┳┓┏┓┳┳┓┏┳┓┏┓┳┓┏┓┳┓┏┓┏┓
#  ┃ ┗┓┃┃┃┫ ┃┗┫┃┃┣┫┣┫┃ ┣┫┗┫━━┃┃┃┣┫┃┃┃ ┃ ┣ ┃┃┣┫┃┃┃ ┣
#  ┻ ┗┛┗┛┛┗┛┻┗┛┗┛┛┗┛┗┗┛┛┗┗┛  ┛ ┗┛┗┻┛┗ ┻ ┗┛┛┗┛┗┛┗┗┛┗┛
#

# An universal menu for system maintenance

# Define variables
scriptDir="$HOME/.config/hypr/scripts"

# Show rofi menu
choice=$(printf "󰣇   Sysmaintenance\n󰮯   Sysmaintenance + Update" | rofi -dmenu -theme ~/.config/rofi/generalMenu.rasi -p " Choose action")

# Do necessary action according to the choice

case "$choice" in
*Sysmaintenance\ +\ Update*) hyprctl dispatch exec '[float]' "uwsm app -- $TERMINAL sh -c '$scriptDir/sysmaintenance.sh --upgrade'" ;;
*Sysmaintenance*) hyprctl dispatch exec '[float]' "uwsm app -- $TERMINAL sh -c '$scriptDir/sysmaintenance.sh'" ;;
*) notify-send -e -h string:x-canonical-private-synchronous:sysmenu "TsukiyoarchyMaintainance" "Nothing selected" -i "$HOME/.config/swaync/icons/bell.png" ;;
esac
