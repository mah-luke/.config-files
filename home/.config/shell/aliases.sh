#! /bin/sh

# --- uni ---
alias sem='cd $SEM'
alias bac='cd $BAC'

# ---- application ---
alias v="nvim"
alias clip="xclip -selection c"
alias paste="clip -o"

alias pdf-merge="gs -dBATCH -DNOPAUSE -q -sDEVICE=pdfwrite -sOutputFile=merge.pdf *"

alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ......="cd ../../../../.."

alias .2="cd ../.."
alias .3=".2 && cd .."
alias .4=".3 && cd .."
alias .5=".4 && cd .."

alias -g runcmd="> /dev/null 2>&1"

# ## muscle memory
alias cat="bat"
alias du="ncdu"

alias synctu="onedrive --confdir=/home/lukas/.config/onedrive/onedrive-TU --synchronize"
alias syncpers="onedrive --confdir=/home/lukas/.config/onedrive/onedrive-PERS --synchronize"

## git

alias gitlogl="git log --oneline --graph --color --all --decorate"
alias gitlog="git log --graph --color --all --decorate"
alias gs="git status"
