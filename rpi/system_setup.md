# Setup of rpi to be used as a home server

It is expected that the (installation)[installation.md] is already done.


## Follow arch install [guide](https://wiki.archlinux.org/title/installation_guide)

```bash
# setup time zone
ln -sf /usr/share/zoneinfo/Europe/Vienna /etc/localtime
hwclock --systohc
```
edit `/etc/locale.gen` & uncomment en_DK.UTF-8 UTF-8
generate locales:
```bash
locale-gen
```

create `/etc/locale.conf`:
```bash
LANG=en_DK.UTF-8
```

update `/etc/hostname`:
```bash
rpi
```

Setup [networking software](https://wiki.archlinux.org/title/Network_configuration), systemd-networkd should already be enabled.



## Userconfig
Change password for root and alarm:
```bash
passwd
```

Create new user:
```bash
useradd -m  -s /usr/bin/zsh lukas
```

and update `/etc/sudoers`:
```bash
visudo
```

copy dotfiles repo and run stow

## AUR
install [paru](https://github.com/Morganamilo/paru):
```bash
sudo pacman -S --needed base-devel
git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si
```

and add paru to itself:
```bash
paru -S paru
```



continue with [hardening](hardening.md)

