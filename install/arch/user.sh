#!/bin/bash

sudo pacman -S --noconfirm \
  docker

flatpak install -y \
  slack spotify joplin dropbox insomnia

# TODO:
#   - install yay
#   - instal yay packages: dashbinsh, zsh-autocomplete-git, lf, betterlockscreen, acpitool
