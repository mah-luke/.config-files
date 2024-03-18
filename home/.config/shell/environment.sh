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

export SEM="$HOME"/OneDrive-TU/Uni/SS2024
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

# home
export DESKTOP_MAC="00:d8:61:16:af:1f"
