# Hyprland Setup

## Applications
Install hyprland and make sure following applications are installed:
- kitty (terminal)
- dolphin (file manager, nautilus is alternative)
- wofi (application selection & running)
- hyprpaper (wallpaper)
- waybar (bar)
- wl-clipboard (clipboard)
- grim & slurp (screenshot)
- brightnessctl (set display & keyboard light)


## Font
Make sure fontconfig is installed. Fira Code is used as default.
Check default font using `fc-match`

## Clipboard
Use cliphist as clipboard manager, neovim is setup to copy/paste on `leader[yp]`
Open the clipboard history with `Super+v`


## Lockscreen

## hypridle
Make sure sleep config is set correctly (see man systemd-sleep.conf)

For Hibernation: Make sure to follow [Arch guide](https://wiki.archlinux.org/title/Power_management/Suspend_and_hibernate#Configure_the_initramfs) to setup hibernation in `/etc/mkinitcpio.conf`.

On NVIDIA systems: Also follow [this guide](https://wiki.archlinux.org/title/NVIDIA/Tips_and_tricks) which contains the section "Preserve video memory after suspend".

## waybar
reload waybar config:

```bash
 pkill waybar --signal=SIGUSR2
```

