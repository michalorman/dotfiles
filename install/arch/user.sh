#!/bin/sh

sudo pacman -S --noconfirm \
  docker docker-compose

flatpak install -y \
  slack spotify joplin dropbox insomnia

# TODO:
#   - install yay
#   - instal yay packages: dashbinsh, zsh-autocomplete-git, lf, betterlockscreen, acpitool

sudo systemctl enable docker

sudo usermod -aG docker $USER
