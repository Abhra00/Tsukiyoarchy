#!/usr/bin/env bash
#  ┳┓┏┓┏┓┳┓┏┓┏┓┓┏
#  ┣┫┣ ┣ ┣┫┣ ┗┓┣┫
#  ┛┗┗┛┻ ┛┗┗┛┗┛┛┗
#

# kill already running processes
_ps=(waybar swaync swayosd-server rofi)
for _prs in "${_ps[@]}"; do
    if pidof "${_prs}" >/dev/null; then
        pkill "${_prs}"
    fi
done

# relaunch waybar
sleep 1
"$HOME"/.config/hypr/scripts/waybar-launch.sh

# relaunch swaync
sleep 0.5
setsid uwsm app -- swaync >/dev/null 2>&1 &

# relaunch swayosd-server
sleep 0.5
setsid uwsm app -- swayosd-server >/dev/null 2>&1 &

# restart fcitx5 to reflect theme switch
sleep 0.5
fcitx5 -r >/dev/null 2>&1 &

# send notification
notify-send \
    -e -h \
    string:x-canonical-private-synchronous:refreshing \
    -i "$HOME/.config/swaync/icons/bell.png" \
    "✨ Refresh ✨" \
    "waybar rofi swayosd swaync fcitx restarted ✨"

exit 0
