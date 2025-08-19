#!/usr/bin/env bash
#  ┳┓┏┓┳┓┳┓┓ ┏┏┓┓ ┓
#  ┣┫┣┫┃┃┃┃┃┃┃┣┫┃ ┃
#  ┛┗┛┗┛┗┻┛┗┻┛┛┗┗┛┗┛
#

# Set variables
wall_dir="$HOME/walls"
scriptsDir="$HOME/.config/hypr/scripts"
focused_monitor=$(hyprctl monitors -j | jq -r '.[] | select(.focused) | .name')
materialYouScrPath="$HOME/.config/wal/material-you-tool/material-you.py"

# Choose a random wallpaper
wall=$(find "$wall_dir" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" \) | shuf -n 1)

# Check if wallpaper was found
if [[ -z "$wall" ]]; then
    echo "❌ No wallpaper found in $wall_dir"
    exit 1
fi

# Ensure hyprpaper is running under uwsm
if ! pgrep -x "hyprpaper" >/dev/null; then
    echo "🚀 Starting hyprpaper..."
    setsid uwsm app -- hyprpaper >/dev/null 2>&1 &
    sleep 0.5 # give time for socket to be ready
else
    echo "✅ hyprpaper is already running"
fi

# Preload and set wallpaper
hyprctl hyprpaper preload "$wall"
sleep 0.1
hyprctl hyprpaper wallpaper "$focused_monitor,$wall"

# Material You mode
if [[ $(<~/.local/share/themeMode) == "material-you" ]]; then
    python3 "${materialYouScrPath}" "${wall}"
    sleep 0.2
    "$scriptsDir/magic.sh" "✨ Material-You-Magic ✨"
    exit 0
fi

# Run the magic script
sleep 0.2
"$scriptsDir/magic.sh" "✨ ThemeMagic ✨"
