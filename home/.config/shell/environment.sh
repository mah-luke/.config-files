#! /bin/sh

# add keyring / ssh key support
SSH_AUTH_SOCK=/run/user/"$(id -u)"/keyring/ssh
export SSH_AUTH_SOCK

# Use nvim as editor
export VISUAL=/usr/bin/nvim
export EDITOR="$VISUAL"

export sem="$HOME"/OneDrive-TU/Uni/7.Semester
export bac="$HOME"/OneDrive-TU/Uni/Bachelorarbeit

export sse_pw=abebohw5EeWietha6soK
export sse=~/Programming/uni/sse/Sec4SystemsEngineering_lab1