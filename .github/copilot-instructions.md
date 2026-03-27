# Copilot Instructions for .config-files

## Repository Overview

This is a **dotfiles repository** that manages system and application configurations using [GNU Stow](https://www.gnu.org/software/stow/). It contains configurations for a Linux system (Arch-based) with both GNOME and Hyprland desktop environments.

## Deployment

Use the `run-stow.sh` script to deploy configurations. It uses GNU Stow with the `--adopt` flag:
- `home/` → `$HOME`
- `etc/` → `/etc` (requires sudo)
- `usr/` → `/usr` (requires sudo)

The script stashes local changes, adopts any manual edits back into the repo, then resets to maintain the repo as the source of truth.

## Structure

- **home/.config/**: Application configs (nvim, tmux, git, hyprland, etc.)
- **home/.config/shell/**: Shell configuration split into modular files:
  - `environment.sh`: XDG variables, editor settings, fzf configuration
  - `aliases.sh`: Command aliases and shortcuts
  - `custom.sh`, `startup.sh`: Additional shell customization
- **etc/**: System-level configs (keyd keyboard remapping, ssh, hosts)
- **usr/**: System resources
- **setup/**: Documentation for setting up various tools (nvim, ssh, gnome, hyprland, etc.)
- **rpi/**: Raspberry Pi specific configs and scripts
- **applications/**: Application-specific notes and commands

## Key Tools & Technologies

### Neovim
- **Package manager**: lazy.nvim
- **LSP**: Configured in `home/.config/nvim/lua/plugins/lsp/`
- **Plugins**: 21+ plugins in `home/.config/nvim/lua/plugins/`
- **Structure**: Modular Lua config with `user.options`, `user.keymaps`, `user.lazy`, `user.autocmds`
- **Special features**: 
  - Jupyter notebook support with Molten plugin (see setup/nvim.md)
  - Java development with jdtls and DAP integration
  - Rust REPL via evcxr_jupyter kernel

### Shell (Zsh)
- **Framework**: oh-my-zsh
- **Plugins**: autoswitch_virtualenv, git, z, zsh-autosuggestions, zsh-syntax-highlighting
- **Prompt**: Starship (configured in `home/.config/starship.toml`)
- **Environment**: Shell config is sourced via `.zshenv` → `.config/shell/environment.sh`

### Keyboard Remapping
- **Tool**: [keyd](https://github.com/rvaiya/keyd) for Wayland
- **Config**: `etc/keyd/default.conf`
- **Features**: Layer-based key remapping (leftalt/rightalt activate layers 1/2/3)

### Tmux
- **Config**: `home/.config/tmux/tmux.conf`
- **Plugin manager**: tpm
- **Theme**: tinted-tmux (base16 colorscheme integration)
- **Prefix**: C-Space

### Git
- **Pager**: delta
- **Commits**: GPG signing enabled by default
- **Merge**: diff3 conflict style
- **Pull**: Rebase by default

### Hyprland (Wayland Compositor)
- **Config**: `home/.config/hypr/hyprland.conf`
- **Related**: waybar, wofi, hypridle, hyprlock, hyprpaper
- **Terminal**: ghostty (set as `$terminal`)

## Conventions

### File Organization
- **Stow packages**: Each top-level directory (home, etc, usr) is a stow package
- **Ignored files**: `.stow-local-ignore` excludes `.git`, `misc/`, and `.md`/`.org` files from stowing

### Shell Aliases
- `v` = nvim
- `cat` = bat (replaced for syntax highlighting)
- Custom git shortcuts: `gs`, `gc`, `gcm`, `gitlogl`, `gitlog`
- Pacman shortcuts with fzf: `pacs`, `pacr`, `pacq`, `aurs`, `paco`

### Setup Documentation
- Each tool has setup instructions in `setup/<tool>.md`
- These are NOT stowed (excluded by `.stow-local-ignore`)
- Document dependencies, installation steps, and troubleshooting

### Device-Specific Configuration
- The bottom of `run-stow.sh` has a section marked "DEVICE SPECIFIC" for per-machine overrides
- Use conditional logic based on hostname or hardware IDs

## Editing Configurations

When modifying configs:
1. Edit files in this repository
2. Run `./run-stow.sh` to deploy changes
3. For system configs (etc/, usr/), you'll need sudo
4. If you manually edited a file in the home directory, stow with `--adopt` will pull it back into the repo

## Important Notes

- **Editor**: nvim is set as `$VISUAL` and `$EDITOR` system-wide
- **Manpages**: Rendered in nvim via `MANPAGER="nvim +Man!"`
- **XDG compliance**: All XDG directories properly configured in environment.sh
- **GPG**: Commits and tags are GPG-signed
- **Display**: Multi-monitor setup with specific configurations for different displays
