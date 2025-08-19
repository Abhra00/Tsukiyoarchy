#!/usr/bin/env bash
#  ┏┓┏┓┓ ┏┏┓┳┓┳┳┓┏┓┳┓┳┳
#  ┃┃┃┃┃┃┃┣ ┣┫┃┃┃┣ ┃┃┃┃
#  ┣┛┗┛┗┻┛┗┛┛┗┛ ┗┗┛┛┗┗┛
#

# Define system menu function
show_system_menu() {
    choice=$(printf "  Lock\n󰤄  Suspend\n  Relaunch\n  Restart\n  Shutdown" | walker --dmenu --theme dmenu_250 -p "Power Menu ")
    case "$choice" in
    *Lock*) loginctl lock-session ;;
    *Suspend*) systemctl suspend ;;
    *Relaunch*) uwsm stop ;;
    *Restart*) systemctl reboot ;;
    *Shutdown*) systemctl poweroff ;;
    *) notify-send -e -h string:x-canonical-private-synchronous:power_menu "Power Menu" "Nothing selected" -i "$HOME/.config/swaync/icons/bell.png" ;;
    esac
}

# Run show_system_menu function
show_system_menu
