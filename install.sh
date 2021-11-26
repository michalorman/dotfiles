#!/usr/bin/env bash

source lib/helpers.sh

install_linux() {
	header1 "Configuring Linux..."

	source install/pacman.sh
}

install_mac() {
	header1 "Configuring Mac..."

	source install/brew.sh
	source install/zsh.sh
	source install/git.sh
	source install/nvim.sh
	source install/alacritty.sh
	source install/tmux.sh

	header1 "\n👍 Mac is ready!"
}

case "$(uname -s)" in
	Linux*)
		install_linux
		;;
	Darwin*)
		install_mac
		;;
esac
