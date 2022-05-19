#! /bin/sh

# add keyring / ssh key support
export SSH_AUTH_SOCK=/run/user/$(id -u)/keyring/ssh

# Use nvim as editor
export VISUAL=/usr/bin/nvim
export EDITOR="$VISUAL"

export sem=$HOME/OneDrive-TU/Uni/6.Semester

export sse_pw=abebohw5EeWietha6soK
export sse=~/Programming/uni/sse/Sec4SystemsEngineering_lab1