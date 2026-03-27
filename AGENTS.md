# AGENTS.md - Dotfiles Repository Handover Document

## Purpose
- This file is the comprehensive operating guide and handover document for developers and AI coding agents working in this dotfiles repository.
- Scope: `/home/lukas/.config-files` and all tracked subdirectories.
- Primary goal: keep the repo as the source of truth for stowed system/user config.
- Owner: Lukas Mahler (lukas.mah@outlook.at)
- Last Updated: 2026-03-27

## Repository Type & Architecture
- This is a GNU Stow-managed dotfiles repo (not a typical app/library project).
- Main stow packages:
  - `home/` -> `$HOME` (user-level configurations)
  - `etc/` -> `/etc` (system-level configurations, requires sudo)
  - `usr/` -> `/usr` (system resources, currently empty but structured for future use)
- Deployment entry point: `./run-stow.sh`
- Stow ignore patterns defined in: `.stow-local-ignore`

### Stow Workflow Understanding
The deployment script uses the `--adopt` flag intentionally:
1. `git stash` - Saves any uncommitted changes
2. `stow --adopt` - Deploys configs and adopts any manual edits back into repo
3. `git reset --hard` - Resets adopted changes to keep repo as source of truth
4. `git stash apply` - Reapplies original uncommitted changes
This ensures the repository always remains authoritative while allowing temporary local modifications.

## Rules Sources
- Copilot rules file exists: `.github/copilot-instructions.md`.
- Cursor rules were checked and not found:
  - `.cursorrules` (missing)
  - `.cursor/rules/` (missing)

## Copilot Rules (Integrated)
- Treat this as a Linux (Arch-like) personal config repo.
- Use `run-stow.sh` for deployment rather than manually copying files.
- Keep setup docs under `setup/` aligned with real config behavior.
- Preserve modular shell layout in `home/.config/shell/`:
  - `environment.sh`, `aliases.sh`, `custom.sh`, `startup.sh`.
- Preserve Neovim modular layout in `home/.config/nvim/`:
  - `init.lua` loads `user.options`, `user.keymaps`, `user.lazy`, `user.autocmds`.
- Keep device-specific logic in `run-stow.sh` under the `DEVICE SPECIFIC` section.

## High-Value Paths
- Root deploy script: `run-stow.sh`
- Stow ignore config: `.stow-local-ignore`
- Shell config: `home/.config/shell/*.sh`
- Neovim config: `home/.config/nvim/**/*.lua`
- WezTerm config: `home/.config/wezterm/*.lua`
- Raspberry Pi scripts/docs: `rpi/`
- Setup docs (not stowed): `setup/*.md`

## Build / Deploy Commands
- Full deploy (authoritative):
  - `./run-stow.sh`
- Manual deploy to home only:
  - `stow --dir="$PWD" --target="$HOME" home --adopt`
- Manual deploy to system paths:
  - `sudo stow --dir="$PWD" --target=/etc etc --adopt`
  - `sudo stow --dir="$PWD" --target=/usr usr --adopt`
- Dry-run stow preview (safe check):
  - `stow -nv --dir="$PWD" --target="$HOME" home`

## Lint / Format Commands
- Lua format check (entire Neovim config):
  - `stylua --check home/.config/nvim`
- Lua format single file:
  - `stylua --check home/.config/nvim/lua/user/keymaps.lua`
- Lua format write-back:
  - `stylua home/.config/nvim`
- Shell format diff check:
  - `shfmt -d -i 4 -bn -ci -sr run-stow.sh`
- Shell format single file write-back:
  - `shfmt -w -i 4 -bn -ci -sr home/.config/shell/aliases.sh`
- Shell lint (single file):
  - `shellcheck run-stow.sh`

## Test / Validation Commands
- Note: there is no centralized automated test suite in this repo.
- Use syntax/lint/smoke checks as "tests" before committing.
- Shell syntax check (single file):
  - `bash -n run-stow.sh`
- Zsh syntax check (single file):
  - `zsh -n home/.config/shell/aliases.sh`
- Lua syntax check (single file):
  - `luac -p home/.config/nvim/lua/plugins/lsp/config.lua`
- Neovim startup smoke test:
  - `nvim --headless "+qa"`

## Single-Test Equivalents (Use These First)
- Single shell file validation:
  - `bash -n path/to/script.sh && shellcheck path/to/script.sh`
- Single Lua file validation:
  - `luac -p path/to/file.lua && stylua --check path/to/file.lua`
- Single deploy target preview:
  - `stow -nv --dir="$PWD" --target="$HOME" home`

## Style Guidelines: General
- Keep edits minimal and targeted; avoid broad refactors in dotfiles.
- Preserve existing directory and module structure.
- Prefer ASCII characters unless file already uses Unicode.
- Add comments only when a block is non-obvious.
- Keep docs and config in sync when behavior changes.

## Style Guidelines: Imports and Modules
- Lua:
  - Prefer top-level `local x = require("module")` for reused modules.
  - Keep `require(...)` ordering stable and readable.
  - Return tables for plugin specs/modules (`return { ... }` / `return M`).
- Shell:
  - Do not duplicate aliases or exports; update existing definitions in place.

## Style Guidelines: Formatting
- Lua formatting is 4 spaces (see `home/.config/nvim/stylua.toml`).
- Keep Lua tables trailing-comma friendly for clean diffs.
- Shell scripts should be `shfmt`-clean with 4-space indentation.
- Keep line length reasonable; prioritize clarity over compactness.

## Style Guidelines: Types and Data
- Lua is dynamically typed here; document tricky value shapes with names, not verbose comments.
- Prefer explicit booleans/options over implicit truthy behavior in config tables.
- Avoid magic strings duplicated across files; centralize when practical.

## Style Guidelines: Naming
- Shell variables:
  - Environment variables: `UPPER_SNAKE_CASE`
  - Local helper variables: `lower_snake_case`
- Lua identifiers:
  - Local vars/functions: `snake_case`
  - Module table names: short (`M`, `opts`, `config`) where conventional.
- File names should follow existing patterns (`options.lua`, `keymaps.lua`, etc.).

## Style Guidelines: Error Handling
- Shell:
  - Quote variable expansions unless intentional word splitting is needed.
  - Check command failure paths for scripts that modify system state.
  - For new non-trivial scripts, prefer `set -euo pipefail` (or justify omission).
- Lua:
  - Guard optional plugin requires when failure is possible.
  - Prefer explicit fallback behavior over silent failure.

## Change Safety
- Never run destructive git commands unless explicitly requested.
- Be careful with `run-stow.sh`: it contains `git reset --hard` by design.
- Do not execute deployment commands automatically in agent runs unless asked.
- For `/etc` and `/usr` changes, call out sudo/root impact in your summary.

## Agent Workflow (Recommended)
- 1) Read relevant files fully before editing.
- 2) Make minimal patch.
- 3) Run targeted single-file checks first.
- 4) Run broader checks only if needed.
- 5) Summarize behavior impact and any manual steps.

## Commit Message Guidance
- Use concise, intent-first messages:
  - `fix(shell): quote path in startup helper`
  - `feat(nvim): add ltex settings for markdown`
  - `docs(setup): update hyprland bootstrap notes`

## Documentation Expectations
- If config behavior changes, update relevant docs in:
  - `README.md`
  - `setup/*.md`
  - `rpi/README.md` (if Raspberry Pi flow is affected)
- Keep examples runnable and path-accurate.

## Quick Checklist Before Finishing
- Commands used are valid for this repo type (dotfiles, not app build tools).
- Formatting/lint checks run for changed file types.
- No unintended secrets/host-specific values introduced.
- Stow mapping assumptions (`home`, `etc`, `usr`) remain correct.
- Copilot instructions remain satisfied.

---

## Detailed Configuration Architecture

### Shell Configuration (Zsh + Oh-My-Zsh)

**Entry Point**: `home/.zshrc`
- Framework: Oh-My-Zsh (installed at `~/.oh-my-zsh`)
- Prompt: Starship (configured at `home/.config/starship.toml`)
- Vi mode enabled with custom cursor shapes
- Auto-update mode: automatic every 13 days

**Plugins Used**:
- `autoswitch_virtualenv` - Automatic Python venv switching
- `git` - Git aliases and completions
- `z` - Directory jumping
- `zsh-autosuggestions` - Command suggestions
- `zsh-syntax-highlighting` - Syntax highlighting (keep at end)

**Modular Shell Files** (`home/.config/shell/`):
1. **`environment.sh`** - XDG variables, editor settings, fzf configuration
   - Sets `VISUAL`/`EDITOR` to nvim
   - Defines custom directory shortcuts: `$SEM`, `$BAC`, `$NOTES`, `$ws`
   - FZF integration with fd, bat, tree
   - MAC addresses for Wake-on-LAN
   - Tinted tmux options
2. **`aliases.sh`** - Command aliases and shortcuts
   - Navigation: `..`, `...`, `.2`, `.3` etc.
   - Applications: `v` (nvim), `cat` (bat)
   - Git shortcuts: `gs`, `gc`, `gcm`, `gitlogl`, `gitlog`
   - Pacman/Paru with fzf: `pacs`, `pacr`, `pacsi`, `pacq`, `aurs`, `paco`
   - OneDrive sync: `synctu`, `syncpers`
   - Server management: `desktopwol`, `notify-terraria`
3. **`custom.sh`** - Device-specific customizations (exists but not readable/tracked)
4. **`startup.sh`** - Custom startup script (launches kitty + tmux in directory)

**Key Bindings**:
- Vi mode with `bindkey -v`
- `^v` in vi command mode to edit command in `$EDITOR`
- `KEYTIMEOUT=1` for fast mode switching
- Menu select navigation with hjkl

**Integrations**:
- fzf (key-bindings and completion from `/usr/share/fzf/`)
- direnv hook
- starship prompt
- uv (Python tool) autocompletion
- Auto-start tmux in ghostty terminal

### Neovim Configuration

**Location**: `home/.config/nvim/`
**Plugin Manager**: lazy.nvim (bootstrapped in `lua/user/lazy.lua`)
**Total Plugins**: 22+ plugin files in `lua/plugins/`

**Core Structure** (`init.lua` loads):
1. `user.options` - Vim options and settings
2. `user.keymaps` - Key mappings
3. `user.lazy` - Plugin manager setup
4. `user.autocmds` - Autocommands

**Plugin Categories**:
- **LSP**: `lsp/init.lua`, `lsp/config.lua`, `mason.lua`
  - Configured LSPs: lua_ls, ruff, basedpyright, bashls, rust_analyzer, bacon_ls, clangd, ltex, r_language_server, texlab
  - none-ls for formatting (stylua, shfmt, prettierd)
  - mason for LSP installation management
  - ltex_extra for LaTeX/Markdown spell checking
  - nvim-jdtls for Java development
- **Completion**: `completion.lua` (likely blink.cmp)
- **UI**: `ui.lua`, `colorscheme.lua`, `which-key.lua`, `snacks.lua`
- **Editor**: `editor.lua`, `telescope.lua`, `trouble.lua`, `todo-comments.lua`
- **Language Specific**:
  - `rust.lua` - Rust tooling
  - `jupyter.lua` - Jupyter notebook integration (Molten plugin)
  - `dap.lua` - Debug Adapter Protocol
  - `ft.lua` - Filetype specific settings
- **Git**: `git.lua`
- **AI**: `copilot.lua`, `avante.lua`
- **Notes**: `obsidian.lua`
- **Syntax**: `treesitter.lua`
- **Keymaps**: `keymap.lua`

**Special Features**:
- Jupyter notebook support via Molten plugin (requires imagemagick, python-pynvim, python-cairosvg, python-jupytext, python-pnglatex, python-plotly, python-kaleido)
- Rust REPL via evcxr_jupyter kernel
- Remote Jupyter kernel connection support
- Java debugging with nvim-jdtls + DAP
- LaTeX support with ltex and texlab
- Markdown with ltex for spell checking

**Filetype Plugins**:
- `after/ftplugin/markdown.vim`
- `ftplugin/markdown.lua`
- `ftplugin/rmd.vim`
- Custom spell dictionary: `spell/en.utf-8.add`

**Formatting Config**:
- `stylua.toml` - Lua formatting (4 spaces indentation)

### Git Configuration

**Location**: `home/.config/git/config`

**Key Settings**:
- User: Lukas Mahler (lukas.mah@outlook.at)
- GPG signing: Enabled for commits and tags
- Pull strategy: Rebase
- Pager: delta (with navigate and diff3 conflict style)
- Diff tool: nvim
- Push: Auto-setup remote branches
- Core autocrlf: input
- Git LFS filter enabled
- Verbose commits enabled

### Tmux Configuration

**Location**: `home/.config/tmux/tmux.conf`
**Plugin Manager**: tpm (installed at `/usr/share/tmux-plugin-manager/tpm`)

**Key Settings**:
- Prefix: `C-Space` (Ctrl+Space)
- Vi mode keybindings: `h/j/k/l` for pane navigation
- Base index: 1 (windows and panes start at 1)
- Mouse support enabled
- Status bar: top position
- Theme: tinted-tmux with base16-default-dark

**Plugins**:
- `tmux-plugins/tpm` - Plugin manager
- `christoomey/vim-tmux-navigator` - Seamless vim-tmux navigation
- `tinted-theming/tinted-tmux` - Base16 color scheme integration

**Custom Keybindings**:
- `r` - Reload config
- `-` - Horizontal split (same directory)
- `"` - Vertical split (same directory)
- `%` - Horizontal split (same directory)
- `c` - New window (same directory)
- `q` - Launch new kitty terminal in current pane directory

**Neovim Integration**:
- Focus events enabled
- 256-color support with RGB
- Escape time: 10ms
- Allow passthrough for image.nvim
- Set window titles based on current window name

### Hyprland Configuration

**Location**: `home/.config/hypr/`
**Files**: `hyprland.conf`, `hypridle.conf`, `hyprlock.conf`, `hyprpaper.conf`

**Monitor Setup** (from `hyprland.conf`):
- Auto-detect with fallback to preferred
- Specific configs for:
  - eDP-1: 1920x1080@60 (T495s laptop internal)
  - MSI Optix MAG27CQ: 2560x1440@144
  - HP E24 G4: 1920x1080@60 (portrait mode, transform=3)
  - DP-1: 3440x1440@240 with HDR support (10-bit, VRR enabled)

**Related Tools**:
- waybar (status bar) - `home/.config/waybar/`
- wofi (launcher) - `home/.config/wofi/`
- Terminal: ghostty (set as `$terminal`)

### WezTerm Configuration

**Location**: `home/.config/wezterm/`
**Files**: `wezterm.lua`, `keybinds.lua`, `stylua.toml`

**Key Settings**:
- Color scheme: "Default Dark (base16)"
- Background opacity: 0.99
- Default shell: `$SHELL`
- No automatic window resizing on font change
- Update checking disabled
- Modular keybindings in separate file

### Terminal Emulators

**Ghostty**: `home/.config/ghostty/config`
- Primary terminal for Hyprland
- Auto-starts tmux when launched

**Kitty**: `home/.config/kitty/kitty.conf`
- Base16 color schemes configured
- Used by startup.sh for launching tmux sessions

**Terminator**: `home/.config/terminator/config`
- Legacy terminal config

### Keyboard Remapping

**Tool**: keyd (Wayland-compatible)
**Location**: `home/.config/keyd/`
**Files**: `base.conf`, `app.conf`

**System Service**: `etc/keyd/default.conf`
- Layer-based key remapping
- Custom layouts activated by alt keys

### Additional Configurations

**Font Configuration**: `home/.config/fontconfig/fonts.conf`

**Clangd**: `home/.config/clangd/config.yaml` (C/C++ LSP settings)

**fd**: `home/.config/fd/ignore` (File search ignore patterns)

**ltex**: `home/.config/ltex/`
- `ltex.dictionary.en-US.txt` - Custom dictionary
- `ltex.hiddenFalsePositives.en-US.txt` - Ignored warnings

**QMK**: `home/.config/qmk/qmk.ini` (Keyboard firmware configuration)

**Zathura**: `home/.config/zathura/zathurarc` (PDF viewer)

**Pulseaudio**: `home/.config/pulse/` (Audio settings)
- `default.pa`, `client.conf`, `daemon.conf`

**Systemd User Services**: `home/.config/systemd/`
- `alsamixer.service`
- `certbot.service`

**GPG**: `home/.gnupg/`
- `gpg.conf` - GPG settings
- `gpg-agent.conf` - Agent settings
- SSH key support enabled via `$SSH_AUTH_SOCK`

**Misc Configs**:
- `home/.config/mimeapps.list` - Default applications
- `home/.config/electron-flags.conf` - Electron app flags
- `home/.config/discord/settings.json` - Discord settings
- `home/.config/opencode/opencode.json` - VS Code launcher
- `home/.config/.clang-format` - C/C++ formatting
- `home/.config/.bashrc` - Bash configuration (fallback)

### System-Level Configurations

**etc/ Package** (deployed to `/etc`):
- `etc/hosts` - Custom host entries
- `etc/keyd/default.conf` - System-wide keyboard remapping

**usr/ Package** (deployed to `/usr`):
- Currently empty but structured for future system resources

### Local Bin Scripts

**Location**: `home/.local/bin/`
**Scripts**:
- `update_mirrors.sh` - Update Arch mirrorlist
- `qpaeq_manage` - PulseAudio equalizer management
- `tu_vpn` - University VPN connection script

---

## Setup Documentation

**Location**: `setup/`
**Purpose**: Installation and configuration guides (NOT stowed)

**Available Guides**:
- `nvim.md` - Neovim setup, Jupyter integration, Rust REPL
- `ssh.md` - SSH configuration
- `gpg.md` - GPG key setup
- `tmux.md` - Tmux installation
- `hyprland.md` - Hyprland setup
- `gnome.md` - GNOME desktop setup
- `podman.md` - Podman container setup
- `colorscheme.md` - Base16 color scheme setup
- `twingate.md` - Twingate VPN
- `tu_mail.md` - University email setup
- `nexus_using_proton.md` - Gaming with Proton

**Setup Scripts**:
- `oh-my-zsh.sh` - Install oh-my-zsh
- `onedrive.sh` - OneDrive client setup
- `uni-vpn.sh` - University VPN setup
- `gnome.sh` - GNOME extensions and settings

---

## Raspberry Pi Configuration

**Location**: `rpi/`
**Purpose**: Raspberry Pi server setup documentation and scripts

**Documentation**:
- `README.md` - Overview
- `installation.md` - Initial Pi setup
- `system_setup.md` - System configuration
- `hardening.md` - Security hardening
- `ddns.md` - Dynamic DNS setup

**Scripts**:
- `scripts/new_user.sh` - User creation script

**Config**:
- `.env` - Environment variables (likely for secrets, not tracked)

---

## Application Notes

**Location**: `applications/`
**Purpose**: Application-specific usage notes

**Files**:
- `pacman.md` - Pacman package manager tips
- `useful_commands.md` - Command reference

---

## Project Management

**todo.md**: Planned changes
- nvim: rainbow brackets, rust-tools

---

## Environment-Specific Behavior

### Device Detection
- Device-specific config can be added to the "DEVICE SPECIFIC" section in `run-stow.sh`
- Shell-level device config: `home/.config/shell/custom.sh` (sourced conditionally in `.zshrc`)

### Conditional Loading
- Tmux auto-starts only in ghostty terminal (`$TERM = "xterm-ghostty"`)
- SSH agent socket: `$XDG_RUNTIME_DIR/gcr/ssh`
- Editor: vim over SSH, nvim locally

---

## Important Tool Versions and Dependencies

### System Requirements
- OS: Arch Linux (or Arch-based)
- Display Servers: Wayland (Hyprland), X11 (GNOME)
- Shell: Zsh with oh-my-zsh
- Terminal: ghostty (primary), kitty, wezterm

### Key Dependencies
- GNU Stow - Symlink management
- Neovim (latest) - Primary editor
- Tmux - Terminal multiplexer
- Git with delta - Version control
- Starship - Shell prompt
- fzf - Fuzzy finder
- fd - File finder
- bat - cat replacement
- ripgrep - grep replacement
- direnv - Directory environment manager
- keyd - Keyboard remapping
- uv - Python tool manager

### Python Dependencies (for Neovim Jupyter)
- python-pynvim
- python-cairosvg
- python-jupytext
- python-pnglatex
- python-plotly
- python-kaleido
- jupyter
- imagemagick (system)

### Rust Dependencies
- evcxr_jupyter (AUR) - Rust REPL kernel

---

## Maintenance and Updates

### Regular Tasks
- Oh-My-Zsh: Auto-updates every 13 days
- Arch mirrors: Use `mirror` alias or `update_mirrors.sh`
- Orphaned packages: Use `paco` alias to remove

### Backup Strategy
- This repository IS the backup for configurations
- Deploy with `./run-stow.sh` to restore configs
- No automated backup mentioned; rely on git history

### Secrets Management
- GPG keys for git signing
- `.env` files in `rpi/` (not tracked)
- `custom.sh` may contain secrets (not readable/tracked)
- SSH keys managed via gcr/ssh agent

---

## Known Issues and Limitations

### From todo.md
- Rainbow brackets not yet configured in nvim
- rust-tools not yet added

### From setup/nvim.md
- Remote Jupyter connection to DIC lab not working (ports/SSH issue)
- jupyterhub route suggested as alternative

### Shell Configuration
- `custom.sh` file exists but permissions prevent reading (likely intentional for secrets)

---

## Development Workflow Recommendations

### For Shell Changes
1. Edit files in `home/.config/shell/`
2. Test syntax: `zsh -n <file>`
3. Format: `shfmt -w -i 4 -bn -ci -sr <file>`
4. Lint: `shellcheck <file>` (if applicable)
5. Deploy: `./run-stow.sh`
6. Restart shell or `source ~/.zshrc`

### For Neovim Changes
1. Edit files in `home/.config/nvim/`
2. Test syntax: `luac -p <file>`
3. Format: `stylua <file>`
4. Deploy: `./run-stow.sh`
5. Restart nvim or `:source %`
6. Check health: `:checkhealth`

### For System Configs (etc/, usr/)
1. Edit files in repo
2. Deploy with sudo: `./run-stow.sh`
3. May require service restart or system reboot
4. Test in safe environment first

### For Documentation
1. Update relevant `.md` files in `setup/` or root
2. Keep in sync with actual config behavior
3. No stowing needed (docs are excluded)

---

## Troubleshooting Guide

### Stow Issues
- **Conflicts**: Stow will warn if files already exist. Use `--adopt` to pull existing files into repo, or manually resolve.
- **Permissions**: `/etc` and `/usr` require sudo
- **Broken symlinks**: May occur if stow package is removed. Use `stow -D <package>` to clean up.

### Shell Issues
- **Custom aliases not working**: Check if `~/.config/shell/aliases.sh` is sourced in `.zshrc`
- **fzf not working**: Ensure fzf is installed and scripts are at `/usr/share/fzf/`
- **Slow startup**: Profile with `zsh -xv` or disable plugins selectively

### Neovim Issues
- **Plugins not loading**: Check `:Lazy` for errors
- **LSP not working**: Check `:LspInfo` and `:Mason`
- **Jupyter not working**: Verify all Python dependencies installed (see setup/nvim.md)
- **Formatting not working**: Check none-ls sources and tool installation

### Tmux Issues
- **Plugins not loading**: Run `<prefix>I` (Ctrl+Space then Shift+i) to install
- **Colors wrong**: Ensure `$TERM` is set correctly, check tmux-256color
- **Vim navigation not working**: Ensure vim-tmux-navigator plugin is installed

### Hyprland Issues
- **Monitor detection**: Check monitor names with `hyprctl monitors`
- **Keybinds not working**: Check keyd service status: `systemctl status keyd`

---

## Contact and Support

**Owner**: Lukas Mahler
**Email**: lukas.mah@outlook.at
**Repository**: `/home/lukas/.config-files`

For questions about specific configurations:
- Refer to inline comments in config files
- Check setup guides in `setup/`
- Review Copilot instructions in `.github/copilot-instructions.md`
