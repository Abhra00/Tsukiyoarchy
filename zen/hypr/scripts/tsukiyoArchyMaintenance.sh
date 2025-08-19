#!/usr/bin/env bash
# ┏┳┓┏┓┳┳┓┏┓┳┓┏┏┓┏┓┳┓┏┓┓┏┓┏  ┳┳┓┏┓┳┳┓┏┳┓┏┓┳┓┏┓┳┓┏┓┏┓
#  ┃ ┗┓┃┃┃┫ ┃┗┫┃┃┣┫┣┫┃ ┣┫┗┫━━┃┃┃┣┫┃┃┃ ┃ ┣ ┃┃┣┫┃┃┃ ┣
#  ┻ ┗┛┗┛┛┗┛┻┗┛┗┛┛┗┛┗┗┛┛┗┗┛  ┛ ┗┛┗┻┛┗ ┻ ┗┛┛┗┛┗┛┗┗┛┗┛
#

# An universal menu for system maintenance

# Define variables
scriptDir="$HOME/.config/hypr/scripts"

# Show walker menu
choice=$(printf "󰣇   Sysmaintenance\n󰮯   Sysmaintenance + Update\n󰃢   Wipe clipboard history" | walker --dmenu --theme dmenu_400 -p " Choose action")

# Do necessary action according to the choice

case "$choice" in
*Sysmaintenance\ +\ Update*) hyprctl dispatch exec '[float]' "uwsm app -- $TERMINAL sh -c '$scriptDir/sysmaintenance.sh --upgrade'" ;;
*Sysmaintenance*) hyprctl dispatch exec '[float]' "uwsm app -- $TERMINAL sh -c '$scriptDir/sysmaintenance.sh'" ;;
*Wipe*) walker -u && notify-send "Cleared clipboard history" -i "$HOME/.config/swaync/icons/bell.png" ;;
*) notify-send -e -h string:x-canonical-private-synchronous:sysmenu "WallandMaintainance" "Nothing selected" -i "$HOME/.config/swaync/icons/bell.png" ;;
esac
