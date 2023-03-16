#! /bin/sh

ZSH_CUSTOM="${HOME}/.oh-my-zsh/custom"

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

git clone https://github.com/zsh-users/zsh-autosuggestions "${ZSH_CUSTOM}/plugins/zsh-autosuggestions"
git clone "https://github.com/MichaelAquilina/zsh-autoswitch-virtualenv.git" "${ZSH_CUSTOM}/plugins/autoswitch_virtualenv"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "${ZSH_CUSTOM}/plugins/zsh-syntax-highlighting"
