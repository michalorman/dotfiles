#!/bin/bash

set -euo pipefail

create_symlink() {
	local target="$1"
	local link_path="$2"

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

create_symlink "$HOME/Code/system/config/xorg/xinitrc" "$HOME/.xinitrc"
create_symlink "$HOME/Code/system/config/alacritty" "$HOME/.config/alacritty"
create_symlink "$HOME/Code/system/config/nvim" "$HOME/.config/nvim"
create_symlink "$HOME/Code/system/config/picom" "$HOME/.config/picom"
create_symlink "$HOME/Code/system/config/dunst" "$HOME/.config/dunst"
create_symlink "$HOME/Code/system/config/helium-browser-flags.conf" "$HOME/.config/helium-browser-flags.conf"
create_symlink "$HOME/Code/system/config/mimeapps.list" "$HOME/.config/mimeapps.list"

create_symlink "$HOME/Code/system/config/git/gitconfig" "$HOME/.gitconfig"
create_symlink "$HOME/Code/system/config/git/gitignore" "$HOME/.gitignore"

create_symlink "$HOME/Code/system/config/zsh/zshrc" "$HOME/.zshrc"
create_symlink "$HOME/Code/system/config/zsh/zprofile" "$HOME/.zprofile"
create_symlink "$HOME/Code/system/config/zsh/zshenv" "$HOME/.zshenv"
create_symlink "$HOME/Code/system/config/zsh/aliases" "$HOME/.aliases"

create_symlink "$HOME/Code/system/bin" "$HOME/.local/bin"
