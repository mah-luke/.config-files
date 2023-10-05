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
SSH_AUTH_SOCK=/run/user/"$(id -u)"/keyring/ssh
export SSH_AUTH_SOCK

# Use nvim as editor
export VISUAL=/usr/bin/nvim
export EDITOR="$VISUAL"
export MANPAGER="nvim +Man!"

export SEM="$HOME"/OneDrive-TU/Uni/9.Semester
export BAC="$HOME"/OneDrive-TU/Uni/Bachelorarbeit

export sse_pw=abebohw5EeWietha6soK
export sse=~/Programming/uni/sse/Sec4SystemsEngineering_lab1

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
