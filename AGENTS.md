# AGENTS.md

Personal Arch Linux bootstrap + dotfiles repo. No build system, no tests, no CI.

## Setup scripts

- `archsetup.sh` — run with **sudo** from the desktop user on a fresh Arch install. Package profile flags: `--amd`, `--printing`, `--node`; no flags installs everything. Checks out pinned revisions (`OPENDWM_REVISION` / `DMENU_REVISION`) of the `michalorman/opendwm` and `michalorman/dmenu` forks into `~/Code`, builds dmenu, then runs opendwm's Wayland installer. AUR tools (`cliamp`, `herdr`, `voxtype`) are printed at the end and installed separately.
- `dotfilessetup.sh` — run as the **desktop user** (exits if root). Symlinks `config/*` and `bin/` into `$HOME`.
  - The symlink list is **hardcoded**: adding a new dir under `config/` does nothing until a matching `create_symlink` line is added here.
  - It **refuses to replace existing non-symlink files** — the conflicting file must be moved away manually first.

## Layout and non-obvious mappings

- `config/<tool>/` mostly maps to `~/.config/<tool>`, but exceptions: `config/zsh/zshrc` → `~/.zshrc` (same pattern for `zprofile`/`zshenv`/`aliases`), `config/git/gitconfig` → `~/.gitconfig`, and the whole `bin/` dir → `~/.local/bin`.
- `config/herdr/config.toml` is symlinked as a **file** to `~/.config/herdr/config.toml` — the `~/.config/herdr/` dir also holds runtime state (logs, sockets, `session.json`) that must stay local. Prefix is remapped to `ctrl+a`; apply changes to a running server with `herdr server reload-config`.
- `archsetup.sh` builds the pinned Tokyo Night GTK theme into `~/.local/share/themes`; `config/gtk-3.0/` and `config/gtk-4.0/` select `Tokyonight-Dark`. `dotfilessetup.sh` also applies the GTK theme and `prefer-dark` preference through GSettings.
- Wayland session: `zprofile` runs `start-opendwm-wayland` on tty1. The opendwm Wayland installer symlinks `hyprland.lua` into `~/.config/hypr/`, installs the launcher and session entry, and rewrites its `OPENDWM` script path in the checkout. Hyprland config lives in `~/Code/opendwm/wayland/hyprland/hyprland.lua`; dmenu `config.h` lives in `~/Code/dmenu`.

## Conventions

- Setup scripts: bash, `set -euo pipefail`, tab indentation. `bin/` scripts: POSIX `#!/bin/sh`, 2-space indentation.
- No automated tests. Verify shell changes with `bash -n` / `sh -n` and `shellcheck` if available.
- Neovim config uses the builtin `vim.pack` (Neovim 0.12+); plugins are pinned in `config/nvim/nvim-pack-lock.json` (migrated off lazy.nvim). `config/nvim/lua/disabled/` holds intentionally disabled plugin configs — do not "fix" by re-enabling them.
