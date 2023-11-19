#!/bin/bash

BASE=(base-devel linux-headers git networkmanager)
XORG=(xorg-server xorg-xinit xorg-xclipboard xorg-xkill xorg-randr)
SETTINGS=(lxappearance)
TOOLS=( \
  firefox alacritty thunar flatpak zoxide dash exa pavucontrol playerctl \
  fzf ripgrep aws-cli fd shellcheck most sxiv udiskie dunst scrot \
  bat evince pacman-contrib intel-ucode
)
FONTS=(noto-fonts-emoji)
ZSH=(zsh zsh-syntax-highlighting zsh-completions zsh-autosugesstions)
PRINT=(cups cups-pdf system-config-printer sane-airscan simple-scan)

# Base packages
pacman -S --noconfirm "${BASE[@]}" "${XORG[@]}" "${SETTINGS[@]}" "${TOOLS[@]}" "${FONTS[@]}" "${ZSH[@]}" "${PRINT[@]}"

systemctl enable NetworkManager
systemctl enable cups
systemctl enable fstrim.timer

# Enable paccache to cleanup pacman cache weekly
systemctl enable paccache.timer

# Make dash a default shell
ln -sfT dash /usr/bin/sh
