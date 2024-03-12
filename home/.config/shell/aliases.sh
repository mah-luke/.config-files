#! /bin/sh

alias notes='cd $NOTES'

# --- uni ---
alias sem='cd $SEM'
alias bac='cd $BAC'

# ---- application ---
alias v="nvim"
alias clip="xclip -selection c"
alias paste="clip -o"

alias pdf-merge="ghostscript -dBATCH -DNOPAUSE -q -sDEVICE=pdfwrite -sOutputFile=merge.pdf *"

alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ......="cd ../../../../.."

alias .2="cd ../.."
alias .3=".2 && cd .."
alias .4=".3 && cd .."
alias .5=".4 && cd .."

alias -g runcmd="> /dev/null 2>&1 &!"

# muscle memory
alias cat="bat"
# alias du="ncdu"

alias synctu="onedrive --confdir=/home/lukas/.config/onedrive/onedrive-TU --synchronize"
alias syncpers="onedrive --confdir=/home/lukas/.config/onedrive/onedrive-PERS --synchronize"

# git
alias gs="git status"
alias gc="git commit"
alias gcm="git commit -m"
alias gitlogl="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative --decorate"
alias gitlog="git log --graph --color --all --decorate"
alias gs="git status"

# pacman
# alias pacs="pacman -Slq | fzf --multi --preview 'pacman -Si {1}' | xargs -ro sudo pacman -S"
alias pacr="pacman -Qq | fzf --multi --preview 'pacman -Qi {1}' | xargs -ro sudo pacman -Rns"
alias pacs='pacman -Slq | fzf --preview "pacman -Si {}" | xargs -ro sudo pacman -S'
alias pacsi='pacman -Slq | fzf --preview "pacman -Si {}" | xargs -ro pacman -Si'
alias pacq='pacman -Qq | fzf --preview "pacman -Qi {}" | xargs -ro pacman -Qi'
alias explicit-installed='pacman -Qqen | grep -vx "$(pacman -Qqg texlive gnome)"'
alias mirror='sudo reflector --verbose --latest 8 --sort rate --protocol https --save /etc/pacman.d/mirrorlist'
alias aurs='paru -Slq | fzf --preview "paru -Si {}" | xargs -ro paru -S'

# misc
alias get-pdfs="mkdir pdfs && find ./ -type f -exec cp {} -t pdfs \;"
