#!/usr/bin/env bash

source lib/helpers.sh

install_linux() {
	case "$(lsb_release -si)" in
		Pop*)
			source install/popos.sh
		;;
	esac
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
