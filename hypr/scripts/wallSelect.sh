#!/usr/bin/env bash
#  ┓ ┏┏┓┓ ┓ ┏┓┏┓┓ ┏┓┏┓┏┳┓
#  ┃┃┃┣┫┃ ┃ ┗┓┣ ┃ ┣ ┃  ┃
#  ┗┻┛┛┗┗┛┗┛┗┛┗┛┗┛┗┛┗┛ ┻
#

# wallselect.sh – wallpaper picker with live preview + hyprpaper integration
# Author: Abhra Mondal (https://github.com/Abhra00)
#  NOTE: Dependencies: fzf, kitty (with icat), hyprpaper, pywal, material-you color generation python library, gum

# Define variables
WALL_DIR="$HOME/walls"
SCRIPTS_DIR="$HOME/.config/hypr/scripts"
MATERIAL_YOU_SCRIPT="$HOME/.config/wal/material-you-tool/material-you.py"
THEME_MODE_FILE="$HOME/.local/share/themeMode"
FZFRC="$HOME/.config/bashrc/fzfrc"

# Source custom fzfrc
source "$FZFRC"

# Load pywal colors
ACCENT="$color11"
ACCENT2="$color13"
WARN="$color9"
OK="$color10"

# --- Pretty printing helpers ---

say() {
    gum style --border normal --margin "1 2" --padding "0 1" \
        --foreground "$2" "$1"
}

with_spinner() {
    gum spin --spinner dot --spinner.foreground "$ACCENT2" --title "$1" -- bash -c "$2"
}

# --- Kitty preview helpers ---

preview_func() {
    local img="$1"
    kitty +kitten icat --clear --stdin=no --transfer-mode=memory
    kitty +kitten icat \
        --place "${FZF_PREVIEW_COLUMNS}x${FZF_PREVIEW_LINES}@0x0" \
        --transfer-mode=memory --stdin=no "$img" </dev/null
}

unload_all_kitty_images() {
    kitty +kitten icat --clear
}
export -f preview_func unload_all_kitty_images

# --- Wallpaper selection with fzf ---

selection=$(
    find "$WALL_DIR" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" -o -iname "*.gif" \) |
        sort |
        fzf --ansi \
            --border=none \
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

    unload_all_kitty_images

    focused_monitor=$(hyprctl monitors -j | jq -r '.[] | select(.focused) | .name')

    if ! pgrep -x "hyprpaper" >/dev/null; then
        say "❌ Hyprpaper is not running ❌"
        with_spinner "✨ Starting hyprpaper ✨" '
          setsid uwsm app -- hyprpaper >/dev/null 2>&1 &
          while ! pgrep -x hyprpaper >/dev/null; do
            sleep 0.5
          done
        '
        sleep 0.5
        say "✨ Started hyprpaper ✨"
    else
        say "✨ Hyprpaper already running ✨" "$OK"
    fi

    with_spinner "Unloading old wallpapers…" "hyprctl hyprpaper unload all"
    with_spinner "Preloading new wallpaper…" "hyprctl hyprpaper preload '$selection'"
    with_spinner "✨Applying wallpaper✨" "hyprctl hyprpaper wallpaper \"$focused_monitor,$selection\""

    if [[ -f "$THEME_MODE_FILE" && $(<"$THEME_MODE_FILE") == "material-you" ]]; then
        with_spinner "✨Generating Material You colors✨" "python3 '$MATERIAL_YOU_SCRIPT' '$selection'"
        say "✨ Material You Magick ✨" "$ACCENT2"
        "$SCRIPTS_DIR/magic.sh" "✨ Material-You-Magick ✨"
        exit 0
    fi

    say "✨ WallMagick ✨" "$ACCENT2"
    "$SCRIPTS_DIR/magic.sh" "✨ WallMagick ✨"
else
    say "❌ No wallpaper selected ❌" "$WARN"
    notify-send -e -h string:x-canonical-private-synchronous:wallselect_no "Wallselect" "❌ No wallpaper selected" -i $HOME/.config/swaync/icons/bell.png
fi
