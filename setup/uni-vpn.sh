#! /bin/bash

#  Do the required setup to use tu vpn via gnome

sudo pacman -S networkmanager
systemctl enable --now NetworkManager.service

# check running
systemct status NetworkManager.service

# install openconnect
sudo pacman -S networkmanager-openconnect
sudo pacman -S openconnect

# then setup vpn in GUI of gnome
