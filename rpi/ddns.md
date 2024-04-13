# ddns setup


## ddclient
check [wiki](https://wiki.archlinux.org/title/Dynamic_DNS)

Important: make sure no spaces after backslash, especially for token.

## cloudflare-ddns
check [github page](https://github.com/timothymiller/cloudflare-ddns)

docker-compose:

```yaml
version: '3.9'
services:
  cloudflare-ddns:
    image: timothyjmiller/cloudflare-ddns:latest
    container_name: cloudflare-ddns
    security_opt:
      - no-new-privileges:true
    network_mode: 'host'
    environment:
      - PUID=1000
      - PGID=1000
    volumes:
      - /YOUR/PATH/HERE/config.json:/config.json
    restart: unless-stopped
```
