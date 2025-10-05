# SSH Demon
OpenSSH [arch wiki](https://wiki.archlinux.org/title/OpenSSH)

change sshd port from 22 to some higher number in /etc/ssh/sshd_config
only allow ssh keys, create `/etc/ssh/sshd_config.d/20-force_puclickey_auth.conf`:
```bash
PasswordAuthentication no
AuthenticationMethods publickey
```

## SSH client
[SSH_keys arch wiki](https://wiki.archlinux.org/title/SSH_keys)
[Gnome keyring arch wiki](https://wiki.archlinux.org/title/GNOME/Keyring#Disabling)

Use Gnome Keyring as wrapper around ssh-agent (see Gnome Keyring in arch wiki).
Unlocks Keyring at start of user session, adds all keys in `.ssh` dir to ssh-agent.
```bash
sudo pacman -S gcr-4 gnome-keyring
systemctl enable --now --user gcr-ssh-agent.socket
```

As we are using Gnome Keyring, make sure ssh-agent.service is disabled.
```bash
systemctl --user disable ssh-agent.service
```
