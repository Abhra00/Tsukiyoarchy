#!/usr/bin/env bash
#  ┳┓┏┓┏┓┏┓┳┓┳┓
#  ┣┫┣ ┃ ┃┃┣┫┃┃
#  ┛┗┗┛┗┛┗┛┛┗┻┛
#

#!/bin/bash
# /* ---- 💫 https://github.com/JaKooLit 💫 ---- */  ##
# Wayland screen recording script (wf-recorder wrapper)

# ─── VARIABLES ─────────────────────────────────────────────────────────────────
icon="$HOME/.config/swaync/icons/recording.png"
xdgvideo="$(xdg-user-dir VIDEOS)"
output_dir="${xdgvideo:-$HOME/Videos}"
filename="recording_$(date '+%Y-%m-%d_%H.%M.%S').mp4"

# ─── FUNCTIONS ─────────────────────────────────────────────────────────────────

get_audio_output() {
    pactl list sources | grep 'Name' | grep 'monitor' | cut -d ' ' -f2
}

get_active_monitor() {
    hyprctl monitors -j | jq -r '.[] | select(.focused == true) | .name'
}

send_notify() {
    local title="$1"
    local message="$2"
    notify-send "$title" "$message" -a "Recorder" -i "$icon"
}

record_fullscreen() {
    send_notify "Starting recording" "$filename"
    wf-recorder -o "$(get_active_monitor)" --pixel-format yuv420p -f "$output_dir/$filename" -t "$@" &
    disown
}

record_region() {
    if ! region=$(slurp 2>&1); then
        send_notify "Recording cancelled" "Selection was cancelled"
        exit 1
    fi
    send_notify "Starting recording" "$filename"
    wf-recorder --pixel-format yuv420p -f "$output_dir/$filename" -t --geometry "$region" "$@" &
    disown
}

toggle_recording() {
    if pgrep wf-recorder >/dev/null; then
        pkill wf-recorder
        send_notify "Recording Stopped" "Stopped"
        exit 0
    fi
}

launch_menu() {
    if pgrep -x wf-recorder >/dev/null; then
        # Show only the stop option if recording is active
        choice=$(printf "  Stop Recording" | walker --dmenu --theme dmenu_400 -p "  Already recording something")
        [[ "$choice" == *Stop* ]] && toggle_recording
        exit 0
    fi

    # If not recording, show full menu
    choice=$(printf "  Fullscreen\n  Fullscreen + Sound\n󰕩  Record Region\n󰕩  Record Region + Sound" | walker --dmenu --theme dmenu_400 -p "  Select Recording Mode")

    case "$choice" in
    *Fullscreen\ +\ Sound*) record_fullscreen --audio="$(get_audio_output)" ;;
    *Fullscreen*) record_fullscreen ;;
    *Region\ +\ Sound*) record_region --audio="$(get_audio_output)" ;;
    *Region*) record_region ;;
    *) notify-send -e -h string:x-canonical-private-synchronous:recording "Recording" "Nothing selected" -i "$HOME/.config/swaync/icons/bell.png" ;;
    esac
}

# ─── MAIN ──────────────────────────────────────────────────────────────────────

mkdir -p "$output_dir"
cd "$output_dir" || exit 1

# If argument passed, handle CLI mode
case "$1" in
--fullscreen) record_fullscreen ;;
--fullscreen-sound) record_fullscreen --audio="$(get_audio_output)" ;;
--region) record_region ;;
--sound) record_region --audio="$(get_audio_output)" ;;
*) launch_menu ;;
esac

exit 0
