#!/bin/bash

set -euo pipefail

if (( EUID == 0 )); then
	printf 'Run this script as the desktop user, not root.\n' >&2
	exit 1
fi

REPO_DIR="$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")"

create_symlink() {
	local target="$1"
	local link_path="$2"

	if [[ ! -e "$target" ]]; then
		printf 'Refusing to link a missing target: %s\n' "$target" >&2
		return 1
	fi

	if [[ -L "$link_path" ]]; then
		if [[ "$(readlink "$link_path")" == "$target" ]]; then
			return
		fi

		rm "$link_path"
	elif [[ -e "$link_path" ]]; then
		printf 'Refusing to replace existing non-symlink: %s\n' "$link_path" >&2
		return 1
	fi

	ln -s "$target" "$link_path"
}

mkdir -p "$HOME/.config" "$HOME/.local"

create_symlink "$REPO_DIR/config/xorg/xinitrc" "$HOME/.xinitrc"
create_symlink "$REPO_DIR/config/alacritty" "$HOME/.config/alacritty"
create_symlink "$REPO_DIR/config/ghostty" "$HOME/.config/ghostty"
create_symlink "$REPO_DIR/config/nvim" "$HOME/.config/nvim"
create_symlink "$REPO_DIR/config/picom" "$HOME/.config/picom"
create_symlink "$REPO_DIR/config/dunst" "$HOME/.config/dunst"
create_symlink "$REPO_DIR/config/voxtype" "$HOME/.config/voxtype"
create_symlink "$REPO_DIR/config/yazi" "$HOME/.config/yazi"
create_symlink "$REPO_DIR/config/helium-browser-flags.conf" "$HOME/.config/helium-browser-flags.conf"
create_symlink "$REPO_DIR/config/mimeapps.list" "$HOME/.config/mimeapps.list"

mkdir -p "$HOME/.config/systemd/user"
create_symlink "$REPO_DIR/config/systemd/user/x11-session.target" "$HOME/.config/systemd/user/x11-session.target"
systemctl --user daemon-reload

create_symlink "$REPO_DIR/config/git/gitconfig" "$HOME/.gitconfig"
create_symlink "$REPO_DIR/config/git/gitignore" "$HOME/.gitignore"

create_symlink "$REPO_DIR/config/zsh/zshrc" "$HOME/.zshrc"
create_symlink "$REPO_DIR/config/zsh/zprofile" "$HOME/.zprofile"
create_symlink "$REPO_DIR/config/zsh/zshenv" "$HOME/.zshenv"
create_symlink "$REPO_DIR/config/zsh/aliases" "$HOME/.aliases"
create_symlink "$REPO_DIR/config/tmux/tmux.conf" "$HOME/.tmux.conf"

create_symlink "$REPO_DIR/bin" "$HOME/.local/bin"
