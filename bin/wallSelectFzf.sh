#!/usr/bin/env bash
#  ┓ ┏┏┓┓ ┓ ┏┓┏┓┓ ┏┓┏┓┏┳┓
#  ┃┃┃┣┫┃ ┃ ┗┓┣ ┃ ┣ ┃  ┃
#  ┗┻┛┛┗┗┛┗┛┗┛┗┛┗┛┗┛┗┛ ┻
#

# wallselect.sh – wallpaper picker with live preview + hyprpaper integration
# Author: Bugs (https://github.com/Abhra00)
#  NOTE: Dependencies: fzf, chafa, hyprpaper, pywal, material-you color generation python library, gum

# Define variables
WALL_DIR="$HOME/walls"
SCRIPTS_DIR="$HOME/.config/hypr/scripts"
MATERIAL_YOU_SCRIPT="$HOME/.config/wal/material-you-tool/material-you.py"
THEME_MODE_FILE="$HOME/.local/share/themeMode"
BASH_VARS="$HOME/.cache/wal/bash-variables.bash"

# Load pywal colors if available
if [[ -f "$BASH_VARS" ]]; then
    source "$BASH_VARS"
    ACCENT="$color2"
    ACCENT2="$color4"
    WARN="$color1"
    OK="$color10"
else
    ACCENT="cyan"
    ACCENT2="magenta"
    WARN="red"
    OK="green"
fi

# --- Pretty printing helpers ---

say() {
    gum style --border normal --margin "1 2" --padding "0 1" \
        --foreground "$2" "$1"
}

with_spinner() {
    gum spin --spinner dot --spinner.foreground "$ACCENT" --title "$1" -- bash -c "$2"
}

# --- Image preview helpers ---
preview_func() {
    local img="$1"
    printf '\033_Ga=d\033\\' # Clear the previous images
    chafa -f kitty -s "${FZF_PREVIEW_COLUMNS}x${FZF_PREVIEW_LINES}" "$img"
}

export -f preview_func

# --- Wallpaper selection with fzf ---

selection=$(
    find "$WALL_DIR" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" -o -iname "*.gif" \) |
        sort |
        fzf --ansi \
            --border=sharp \
            --layout=reverse \
            --height=100% \
            --preview 'bash -c "preview_func {}"' \
            --preview-window=right:70% \
            --prompt="󰸉 Select Wallpaper: " \
            --bind "ctrl-r:reload(find \"$WALL_DIR\" -type f | sort)"
)

# --- Apply wallpaper if selected ---

if [[ -n "$selection" ]]; then
    say "Setting wallpaper" "$ACCENT"
    echo "$selection"

    focused_monitor=$(hyprctl monitors -j | jq -r '.[] | select(.focused) | .name')

    if ! pgrep -x "hyprpaper" >/dev/null; then
        with_spinner "Starting hyprpaper…" "hyprpaper & sleep 0.5"
    else
        say "hyprpaper already running" "$OK"
    fi

    with_spinner "Unloading old wallpapers…" "hyprctl hyprpaper unload all"
    with_spinner "Preloading new wallpaper…" "hyprctl hyprpaper preload '$selection'"
    with_spinner "Applying wallpaper…" "hyprctl hyprpaper wallpaper \"$focused_monitor,$selection\""

    if [[ -f "$THEME_MODE_FILE" && $(<"$THEME_MODE_FILE") == "material-you" ]]; then
        with_spinner "Generating Material You colors…" "python3 '$MATERIAL_YOU_SCRIPT' '$selection'"
        say "✨ Material You Magick 💫" "$ACCENT2"
        "$SCRIPTS_DIR/magic.sh" "✨ Material-You-Magick 💫"
        exit 0
    fi

    say "✨ WallMagick 💫" "$ACCENT2"
    "$SCRIPTS_DIR/magic.sh" "✨ WallMagick 💫"
else
    say "❌ No wallpaper selected" "$WARN"
    notify-send "Wallselect" "❌ No wallpaper selected" -i $HOME/.config/swaync/icons/bell.png
fi
