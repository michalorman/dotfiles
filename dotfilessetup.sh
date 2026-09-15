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

remove_symlink() {
	local target="$1"
	local link_path="$2"

	if [[ -L "$link_path" && "$(readlink "$link_path")" == "$target" ]]; then
		rm "$link_path"
	fi
}

mkdir -p "$HOME/.config" "$HOME/.local"

remove_symlink "$REPO_DIR/config/xorg/xinitrc" "$HOME/.xinitrc"
remove_symlink "$REPO_DIR/config/picom" "$HOME/.config/picom"
remove_symlink "$REPO_DIR/config/systemd/user/x11-session.target" "$HOME/.config/systemd/user/x11-session.target"
remove_symlink "$REPO_DIR/config/tmux/tmux.conf" "$HOME/.tmux.conf"
remove_symlink "$REPO_DIR/config/dunst" "$HOME/.config/dunst"
remove_symlink "$REPO_DIR/config/swaylock" "$HOME/.config/swaylock"

create_symlink "$REPO_DIR/config/alacritty" "$HOME/.config/alacritty"
create_symlink "$REPO_DIR/config/ghostty" "$HOME/.config/ghostty"
mkdir -p "$HOME/.config/hypr"
create_symlink "$REPO_DIR/config/hypr/hyprlock.conf" "$HOME/.config/hypr/hyprlock.conf"
create_symlink "$REPO_DIR/config/hypr/hypridle.conf" "$HOME/.config/hypr/hypridle.conf"
mkdir -p "$HOME/.config/gtk-3.0" "$HOME/.config/gtk-4.0"
create_symlink "$REPO_DIR/config/gtk-3.0/settings.ini" "$HOME/.config/gtk-3.0/settings.ini"
create_symlink "$REPO_DIR/config/gtk-3.0/gtk.css" "$HOME/.config/gtk-3.0/gtk.css"
create_symlink "$REPO_DIR/config/gtk-4.0/settings.ini" "$HOME/.config/gtk-4.0/settings.ini"
create_symlink "$REPO_DIR/config/nvim" "$HOME/.config/nvim"
create_symlink "$REPO_DIR/config/mako" "$HOME/.config/mako"
create_symlink "$REPO_DIR/config/voxtype" "$HOME/.config/voxtype"
create_symlink "$REPO_DIR/config/yazi" "$HOME/.config/yazi"
create_symlink "$REPO_DIR/config/helium-browser-flags.conf" "$HOME/.config/helium-browser-flags.conf"
create_symlink "$REPO_DIR/config/mimeapps.list" "$HOME/.config/mimeapps.list"

mkdir -p "$HOME/.config/herdr"
create_symlink "$REPO_DIR/config/herdr/config.toml" "$HOME/.config/herdr/config.toml"

create_symlink "$REPO_DIR/config/git/gitconfig" "$HOME/.gitconfig"
create_symlink "$REPO_DIR/config/git/gitignore" "$HOME/.gitignore"

create_symlink "$REPO_DIR/config/zsh/zshrc" "$HOME/.zshrc"
create_symlink "$REPO_DIR/config/zsh/zprofile" "$HOME/.zprofile"
create_symlink "$REPO_DIR/config/zsh/zshenv" "$HOME/.zshenv"
create_symlink "$REPO_DIR/config/zsh/aliases" "$HOME/.aliases"
create_symlink "$REPO_DIR/bin" "$HOME/.local/bin"

if command -v gsettings >/dev/null 2>&1; then
	gsettings set org.gnome.desktop.interface gtk-theme Tokyonight-Dark \
		|| printf 'Unable to set GTK theme with gsettings.\n' >&2
	gsettings set org.gnome.desktop.interface icon-theme Tokyonight-Dark \
		|| printf 'Unable to set icon theme with gsettings.\n' >&2
	gsettings set org.gnome.desktop.interface color-scheme prefer-dark \
		|| printf 'Unable to set dark-mode preference with gsettings.\n' >&2
fi
