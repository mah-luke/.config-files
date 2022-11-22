#! /bin/bash

# XDG Variables
export XDG_RUNTIME_DIR="/run/user/$UID"
export DBUS_SESSION_BUS_ADDRESS="unix:path=${XDG_RUNTIME_DIR}/bus"

# add keyring / ssh key support
SSH_AUTH_SOCK=/run/user/"$(id -u)"/keyring/ssh
export SSH_AUTH_SOCK

# Use nvim as editor
export VISUAL=/usr/bin/nvim
export EDITOR="$VISUAL"
export MANPAGER="nvim +Man!"

export SEM="$HOME"/OneDrive-TU/Uni/7.Semester
export BAC="$HOME"/OneDrive-TU/Uni/Bachelorarbeit

export sse_pw=abebohw5EeWietha6soK
export sse=~/Programming/uni/sse/Sec4SystemsEngineering_lab1