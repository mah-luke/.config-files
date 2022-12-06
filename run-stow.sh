#!/bin/sh

# --- DEFAULT CONFIG ---

# correct path even if script was called via sudo
DIR="$(eval echo ~"${SUDO_USER}")/.config-files"

git stash

stow --dir="$DIR" --target="$HOME" home --adopt
sudo stow --dir="$DIR" --target=/etc etc --adopt
# sudo stow --dir="$DIR" --target=/usr usr --adopt


# Remove changes caused by adopt
git reset --hard

git stash apply

# --- DEVICE SPECIFIC ---

# needs fix:
# load-module module-equalizer-sink
# load-module module-dbus-protocol
