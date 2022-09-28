#! /bin/sh


# --- uni ---
alias sem="cd $HOME/OneDrive-TU/Uni/6.Semester"
alias sse="cd $HOME/Programming/uni/sse/Sec4SystemsEngineering_lab1"

# ---- application ---
alias v="nvim"
alias clip="xsel -b"

alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ......="cd ../../../../.."

alias .2="cd ../.."
alias .3=".2 && cd .."
alias .4=".3 && cd .."
alias .5=".4 && cd .."

alias sse="echo ${sse} | xsel -ib"

alias update="sudo apt-get update && sudo apt-get full-upgrade && sudo apt-get dist-upgrade"

eval $(thefuck --alias)
eval $(thefuck --alias FUCK)