# SSH Demon
OpenSSH [arch wiki](https://wiki.archlinux.org/title/OpenSSH)

change sshd port from 22 to some higher number in /etc/ssh/sshd_config
only allow ssh keys, create `/etc/ssh/sshd_config.d/20-force_puclickey_auth.conf`:
```bash
PasswordAuthentication no
AuthenticationMethods publickey
```

## SSH client

enable ssh-agent:
```bash
systemctl --user enable --now ssh-agent.service
```
