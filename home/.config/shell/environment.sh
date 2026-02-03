#! /bin/bash
# XDG Variables
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_DATA_DIRS="/usr/local/share:/usr/share"
export XDG_CONFIG_DIRS="/etc/xdg"
export DBUS_SESSION_BUS_ADDRESS="unix:path=${XDG_RUNTIME_DIR}/bus"

# add keyring / ssh key support
SSH_AUTH_SOCK=${XDG_RUNTIME_DIR}/gcr/ssh
export SSH_AUTH_SOCK

# Use nvim as editor
export VISUAL=/usr/bin/nvim
export EDITOR="$VISUAL"
export MANPAGER="nvim +Man!"

export SEM="$HOME"/OneDrive-TU/Uni/WS2024
export BAC="$HOME"/OneDrive-TU/Uni/Bachelorarbeit
export NOTES=~/OneDrive/Dokumente_Cloud/Notes

export ws=~/Programming/code-workspaces

# --- fzf
export FZF_DEFAULT_COMMAND="fd --follow --hidden"
export FZF_DEFAULT_OPTS="--layout=reverse --multi --bind ctrl-f:preview-down,ctrl-b:preview-up"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS="--preview '[ -f {} ] \
&& bat --style=numbers --color=always {} \
|| tree -a -C -L 1 {}'"
export FZF_ALT_C_COMMAND="$FZF_DEFAULT_COMMAND --type d"
export FZF_ALT_C_OPTS="--preview 'tree -a --gitignore -C -L 1 {}'"

# MAC adresses
export MAC_DESKTOP="00:d8:61:16:af:1f"
export MAC_HAMA_DISK="00:00:00:00:21:BE"
export MAC_K6_PRO="6C:93:08:60:BC:4E"

# tmux
export TINTED_TMUX_OPTION_STATUSBAR=1
# export TINTED_TMUX_OPTION_ACTIVE=1


export QT_QPA_PLATFORMTHEME="qt6ct"

