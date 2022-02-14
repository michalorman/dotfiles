#!/bin/bash

# TODO: add X11 packages server, xinit

# Base packages
pacman -S --noconfirm \
  base-devel linux-headers firefox alcritty git networkmanager lxappearance \
  cups cups-pdf thunar flatpak zoxide zsh dash exa pavucontrol playerctl fzf ripgrep aws-cli \
  fd shellcheck flatpak xinit xorg-xclipboard zsh-syntax-highlighting most sxiv \
  udiskie dunst scrot system-config-printer sane-airscan simple-scan

systemctl enable NetworkManager
systemctl enable cups
systemctl enable fstrim.timer

# Make dash a default shell
ln -sfT dash /usr/bin/sh
