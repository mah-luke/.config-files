# GNOME setup

## Theme
Follow instructions to install the One Dark Theme for GNOME: https://github.com/lonr/adwaita-one-dark



## Keymap

```
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-left "['<Super><Alt>Left']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-right "['<Super><Alt>Right']"
```

## ssh-agent

SSH agent functionality has been moved to gcr-4. Setup is done using this [guide](https://wiki.archlinux.org/title/GNOME/Keyring):

```bash
systemctl --user enable --now gcr-ssh-agent.socket
```

export in rc file (e.g. .zshrc):

```bash
export ${XDG_RUNTIME_DIR}/gcr/ssh
```


## Evolution

Password popups all the time: Just install seahorse, then saving to the keystore works
for whatever reason.

```bash
sudo pacman -S seahorse
```


