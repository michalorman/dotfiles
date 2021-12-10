#!/usr/bin/env bash

header "Configuring PopOS! ..."

[ $(which neofetch) ] && neofetch -L

source install/popos/apt.sh
source install/popos/flatpak.sh
source install/popos/firacode.sh
source install/popos/starship.sh
source install/popos/neovim.sh

source install/shared/node.sh
source install/shared/rustup.sh

header1 "executing dotbot-install"
source dotbot-install

footer "PopOS configured"
