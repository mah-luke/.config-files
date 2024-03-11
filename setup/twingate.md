# Twingate

AUR package available, fails on install

Instead load shellscript from [twingate](https://www.twingate.com/docs/linux), they install their source files using pacman.

Wrong user after install -> do chown

```bash
chown root:root /etc/twingate
```
