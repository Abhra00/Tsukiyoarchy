#!/usr/bin/env bash
#  ┳┳┓┏┓┏┓┳┏┓
#  ┃┃┃┣┫┃┓┃┃
#  ┛ ┗┛┗┗┛┻┗┛
#

# utility variables
focused_monitor=$(hyprctl monitors -j | jq -r '.[] | select(.focused) | .name')
wallpaper_path=$(hyprctl hyprpaper listactive | grep "${focused_monitor}" | awk -F ' = ' '{print $2}')

# set gtk theme
gsettings set org.gnome.desktop.interface gtk-theme ""
gsettings set org.gnome.desktop.interface gtk-theme adw-gtk3

#-------Imagemagick magick 👀--------------#

# copy the wallpaper in current-wallpaper file
sleep 0.5
ln -sf "$wallpaper_path" "$HOME/.local/share/bg"

# make a square icon for using it as a notification-icon
sleep 0.5
magick "$wallpaper_path" -strip -thumbnail 500x500^ -gravity center -extent 500x500 "$HOME/.local/share/bg.sqre"

# send notification after completion
sleep 0.5
notify-send -e -h string:x-canonical-private-synchronous:matugen_notif "$1" "JOB DONE BOIIIII !!!!" -i "$HOME/.local/share/bg.sqre"
