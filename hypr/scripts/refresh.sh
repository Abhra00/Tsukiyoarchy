#!/usr/bin/env bash
#  ┳┓┏┓┏┓┳┓┏┓┏┓┓┏
#  ┣┫┣ ┣ ┣┫┣ ┗┓┣┫
#  ┛┗┗┛┻ ┛┗┗┛┗┛┛┗
#

# kill already running processes
_ps=(waybar swaync swayosd-server walker)
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

# relaunch walker
sleep 0.5
setsid uwsm app -- walker --gapplication-service 2>&1 &

# send notification
notify-send \
    -e -h \
    string:x-canonical-private-synchronous:refreshing \
    -i "$HOME/.config/swaync/icons/bell.png" \
    "✨ Refresh ✨" \
    "waybar walker swayosd swaync restarted ✨"

exit 0
