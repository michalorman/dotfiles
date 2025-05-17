#!/bin/bash

set -euo pipefail

create_symlink() {
	local target="$1"
	local link_path="$2"

	if [[ -L "$link_path" || -d "$link_path" || -f "$link_path" ]]; then
		rm -rf "$link_path"
	fi

	ln -s "$target" "$link_path"
}

mkdir -p "$HOME/.local/bin"

create_symlink "$HOME/Code/system/config/xorg/xinitrc" "$HOME/.xinitrc"
create_symlink "$HOME/Code/system/config/alacritty" "$HOME/.config/alacritty"
create_symlink "$HOME/Code/system/config/nvim" "$HOME/.config/nvim"
create_symlink "$HOME/Code/system/config/picom" "$HOME/.config/picom"
create_symlink "$HOME/Code/system/config/dunst" "$HOME/.config/dunst"

create_symlink "$HOME/Code/system/config/git/gitconfig" "$HOME/.gitconfig"
create_symlink "$HOME/Code/system/config/git/gitignore" "$HOME/.gitignore"

create_symlink "$HOME/Code/system/config/zsh/zshrc" "$HOME/.zshrc"
create_symlink "$HOME/Code/system/config/zsh/zprofile" "$HOME/.zprofile"
create_symlink "$HOME/Code/system/config/zsh/zshenv" "$HOME/.zshenv"
create_symlink "$HOME/Code/system/config/zsh/aliases" "$HOME/.aliases"

create_symlink "$HOME/Code/system/bin" "$HOME/.local/bin"

