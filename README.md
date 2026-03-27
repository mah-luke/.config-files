# .config-files

## Tools

### keyboard mapping in Wayland
keyd  https://github.com/rvaiya/keyd


## Usage
Run the `./run-stow.sh` script located in the repository root directory. This script will automatically deploy all configuration files to their correct system locations using GNU Stow. The script handles both user-level configurations (from `home/` to `$HOME`) and system-level configurations (from `etc/` to `/etc` and `usr/` to `/usr`, which require sudo privileges). The deployment process uses the `--adopt` flag to ensure the repository remains the authoritative source of truth for all configurations.


## Misc
misc folder is ignored by the repository and not included in the deployment process.
