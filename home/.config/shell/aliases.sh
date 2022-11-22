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

alias -g run="> /dev/null 2>&1"


alias synctu="onedrive --confdir=/home/lukas/.config/onedrive/onedrive-TU --synchronize"
alias syncpers="onedrive --confdir=/home/lukas/.config/onedrive/onedrive-PERS --synchronize"