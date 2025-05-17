#!/bin/bash

BUILD=(base-devel linux-headers git)
XORG=(xorg-server xorg-xinit xorg-xclipboard xorg-xkill)
SYSTEM=(lxappearance networkmanager pacman-contrib thunar intel-ucode less most picom j4-dmenu-desktop feh nsxiv)
TOOLS=(alacritty firefox thunar flatpak zoxide dash fzf ripgrep fd udiskie dunst bat eza vim neovim xclip man openssh)
PRINT=(cups cups-pdf system-config-printer sane-airscan simple-scan)
FONTS=(noto-fonts-emoji ttf-jetbrains-mono-nerd ttf-font-nerd)
SHELL=(dash zsh zsh-syntax-highlighting zsh-completions zsh-autosuggestions starship)
DWM=(libx11 libxinerama libxft)
EXTRAS=(lua luarocks)
NODE=(nodejs npm)

pacman -S --noconfirm --needed "${BUILD[@]}" "${XORG[@]}" "${SYSTEM[@]}" "${TOOLS[@]}" "${PRINT[@]}" "${FONTS[@]}" "${SHELL[@]}" "${DWM[@]}" "${EXTRAS[@]}" "${NODE[@]}"

# Make dash a default shell
ln -sfT dash /usr/bin/sh

systemctl enable NetworkManager
systemctl enable cups
systemctl enable fstrim.timer

# Enable paccache to cleanup pacman cache
systemctl enable paccache.timer

