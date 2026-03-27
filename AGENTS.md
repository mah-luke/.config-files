# AGENTS.md

## Purpose
- This file is the operating guide for coding agents working in this dotfiles repository.
- Scope: `/home/lukas/.config-files` and all tracked subdirectories.
- Primary goal: keep the repo as the source of truth for stowed system/user config.

## Repository Type
- This is a GNU Stow-managed dotfiles repo (not a typical app/library project).
- Main stow packages:
  - `home/` -> `$HOME`
  - `etc/` -> `/etc` (sudo)
  - `usr/` -> `/usr` (sudo)
- Deployment entry point: `./run-stow.sh`.

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
