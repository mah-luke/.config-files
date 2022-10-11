#! /bin/sh


# --- uni ---
alias sem='cd $HOME/OneDrive-TU/Uni/7.Semester'

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

alias update="sudo rm -rf /var/lib/dpkg/lock-frontend &&
                sudo rm -rf /var/lib/dpkg/lock &&
                sudo apt-get update && 
                sudo apt-get upgrade -y &&
                sudo apt-get dist-upgrade -y &&
                sudo apt-get autoremove -y &&
                sudo apt-get autoclean -y"
