#!/usr/bin/env bash

header "Configuring PopOS! ..."

if [ $(which neofetch) ]; then
  neofetch -L
fi

source install/popos/apt.sh
source install/popos/flatpak.sh
source install/popos/firacode.sh
source install/popos/starship.sh
source install/popos/neovim.sh

source install/shared/alacritty.sh
source install/shared/fish.sh
source install/shared/starship.sh
source install/shared/git.sh
source install/shared/nvim.sh
source install/shared/tmux.sh
source install/shared/node.sh
source install/shared/rustup.sh

footer "PopOS configured"
