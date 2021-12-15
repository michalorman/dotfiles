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

# Change Alt-Tab behaviour to switch only through apps in current workspace
if [ $(gsettings get org.gnome.shell.app-switcher current-workspace-only) = "false" ]; then
  gsettings set org.gnome.shell.app-switcher current-workspace-only true
fi

header1 "executing dotbot-install"
source dotbot-install

footer "PopOS configured"
