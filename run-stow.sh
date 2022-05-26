#!/bin/sh

# --- DEFAULT CONFIG ---

# correct path even if script was called via sudo
DIR="$(eval echo ~${SUDO_USER})/.config-files"


stow --dir=$DIR --target=$HOME home --adopt
sudo stow --dir=$DIR --target=/etc etc --adopt

# Remove changes caused by adopt
git reset --hard

# --- DEVICE SPECIFIC ---

# needs fix:
# load-module module-equalizer-sink
# load-module module-dbus-protocol
