#! /bin/sh

/usr/bin/onedrive --reauth --confdir=/home/lukas/.config/onedrive/onedrive-TU
systemctl --user --now enable onedrive-TU

/usr/bin/onedrive --reauth --confdir=/home/lukas/.config/onedrive/onedrive-PERS
systemctl --user --now enable onedrive-PERS

# follow logs with: 
# journalctl --user -f -u onedrive-<NAME>
