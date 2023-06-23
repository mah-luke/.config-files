#! /bin/sh
reflector --country 'France,Germany,' --latest 5 |  sudo tee /etc/pacman.d/mirrorlist
