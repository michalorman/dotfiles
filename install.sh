#!/usr/bin/env bash

source lib/helpers.sh

install_linux() {
	case "$(lsb_release -si)" in
		Pop*)
			source install/popos.sh
		;;
	esac

  #source install/garuda.sh
  #source install/fish.sh
  #source install/starship.sh # move to general
}

install_mac() {
  header1 "Configuring Mac..."

  source install/brew.sh
  source install/zsh.sh

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

#source install/git.sh
#source install/nvim.sh
#source install/alacritty.sh
#source install/tmux.sh
#source install/node.sh
