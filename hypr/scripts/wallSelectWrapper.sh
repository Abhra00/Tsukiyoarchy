#!/usr/bin/env bash
# ┓ ┏┏┓┓ ┓ ┏┓┏┓┓ ┏┓┏┓┏┳┓  ┓ ┏┳┓┏┓┏┓┏┓┏┓┳┓
# ┃┃┃┣┫┃ ┃ ┗┓┣ ┃ ┣ ┃  ┃ ━━┃┃┃┣┫┣┫┃┃┃┃┣ ┣┫
# ┗┻┛┛┗┗┛┗┛┗┛┗┛┗┛┗┛┗┛ ┻   ┗┻┛┛┗┛┗┣┛┣┛┗┛┛┗
#

# Wrapper to launch wallSelect.sh in a floating terminal reliably

# --- Config ---
TERMINAL="${TERMINAL:-kitty}" # Default terminal if not set
DESK_SCRIPTS="$HOME/.config/hypr/scripts"
WALLSELECT_SCRIPT="$DESK_SCRIPTS/wallSelect.sh"
FLOAT_SIZE="1600 800"
TITLE="Wallpaper Selector"

# --- Run the floating terminal with wallSelect.sh
hyprctl dispatch exec "[float; size $FLOAT_SIZE]" "uwsm app -- $TERMINAL --title '$TITLE' bash -c '$WALLSELECT_SCRIPT; echo; gum spin --spinner "moon" --title \"Done! Press any key to close...\" -- bash -c 'read -n 1 -s''"
