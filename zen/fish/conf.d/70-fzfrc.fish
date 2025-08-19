#  ━┓┏┓  ┏┓┏┓┏┓┳┓┏┓
#   ┃┃┫━━┣ ┏┛┣ ┣┫┃ 
#   ╹┗┛  ┻ ┗┛┻ ┛┗┗┛
#                  



# Source wal colors (Fish-compatible, FZF_ prefixed)
. ~/.cache/wal/fzf-cols-pywal.fish

# Layout
set -x FZF_LAYOUT "--layout=reverse --height 40% --border=sharp --preview-window=sharp"

# Colors using FZF_ variables from the template
set -x FZF_COLORS "--color=fg:$FZF_FOREGROUND,bg:$FZF_BACKGROUND,hl:$FZF_COLOR10L,fg+:$FZF_FOREGROUND,bg+:$FZF_BACKGROUND3,hl+:$FZF_COLOR12 \
--color=info:$FZF_COLOR10,prompt:$FZF_COLOR13,pointer:$FZF_COLOR10,marker:$FZF_COLOR12L,spinner:$FZF_COLOR14,header:$FZF_COLOR4"

# Key bindings
set -x FZF_BINDS "--bind alt-k:preview-up --bind alt-j:preview-down"


# Combine everything
set -x FZF_DEFAULT_OPTS "$FZF_LAYOUT $FZF_COLORS $FZF_BINDS"

# Enable fzf in tmux
set -x FZF_TMUX 1
