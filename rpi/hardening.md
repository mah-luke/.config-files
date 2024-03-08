# Security stuff

## sshd
upload ssh public key -> to `~/.ssh/authorized_keys`
    only allow ssh keys, create `/etc/ssh/sshd_config.d/20-force_puclickey_auth.conf`:
```bash
PasswordAuthentication no
AuthenticationMethods publickey
```
and reload & restart:

```bash
systemctl reload sshd
systemctl restart sshd
```

also see [arch ssh](https://wiki.archlinux.org/title/OpenSSH)




## firewall


