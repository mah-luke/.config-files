#!/bin/sh

# --- DEFAULT CONFIG ---

# correct path even if script was called via sudo
DIR="$(eval echo ~${SUDO_USER})/.config-files"

stow --dir=$DIR --target=$HOME home
sudo stow --dir=$DIR --target=/etc etc


# --- DEVICE SPECIFIC ---
