#!/bin/bash

set -euo pipefail

BUILD=(base-devel linux-headers git)
XORG=(xorg-server xorg-xinit xorg-xclipboard xorg-xkill)
SYSTEM=(lxappearance networkmanager pacman-contrib thunar intel-ucode less most picom j4-dmenu-desktop feh nsxiv playerctl pavucontrol)
TOOLS=(alacritty firefox thunar flatpak zoxide dash fzf ripgrep fd udiskie dunst bat eza vim neovim tree-sitter-cli xclip man openssh flameshot)
PRINT=(cups cups-pdf system-config-printer sane-airscan simple-scan)
FONTS=(noto-fonts-emoji ttf-jetbrains-mono-nerd ttf-font-nerd)
SHELL=(dash zsh zsh-syntax-highlighting zsh-completions zsh-autosuggestions)
DWM=(libx11 libxinerama libxft)
EXTRAS=(lua luarocks ffmpeg vlc vlc-plugin-ffmpeg lsof)
NODE=(nodejs npm)

if (( EUID != 0 )); then
	printf 'Run this script with sudo.\n' >&2
	exit 1
fi

TARGET_USER="${SUDO_USER:-root}"
PASSWD_ENTRY="$(getent passwd "$TARGET_USER")"
IFS=: read -r _ _ _ _ _ TARGET_HOME TARGET_SHELL <<< "$PASSWD_ENTRY"
TARGET_GROUP="$(id -gn "$TARGET_USER")"
CODE_DIR="$TARGET_HOME/Code"

run_as_target_user() {
	if [[ "$TARGET_USER" == "root" ]]; then
		"$@"
	else
		sudo -u "$TARGET_USER" env HOME="$TARGET_HOME" "$@"
	fi
}

install_git_project() {
	local name="$1"
	local repo_url="$2"
	local repo_dir="$CODE_DIR/$name"

	if [[ -e "$repo_dir" && ! -d "$repo_dir/.git" ]]; then
		printf 'Refusing to use %s because it exists but is not a git checkout.\n' "$repo_dir" >&2
		return 1
	fi

	if [[ ! -d "$repo_dir" ]]; then
		run_as_target_user git clone "$repo_url" "$repo_dir"
	else
		printf '%s already cloned at %s.\n' "$name" "$repo_dir"
	fi

	if [[ ! -f "$repo_dir/config.h" ]]; then
		run_as_target_user cp "$repo_dir/examples/config.h" "$repo_dir/config.h"
	else
		printf '%s config.h already exists; leaving it unchanged.\n' "$name"
	fi

	if command -v "$name" >/dev/null 2>&1; then
		printf '%s already installed at %s; rebuilding from local checkout.\n' "$name" "$(command -v "$name")"
	fi

	run_as_target_user make -C "$repo_dir"
	make -C "$repo_dir" install
}

pacman -S --noconfirm --needed "${BUILD[@]}" "${XORG[@]}" "${SYSTEM[@]}" "${TOOLS[@]}" "${PRINT[@]}" "${FONTS[@]}" "${SHELL[@]}" "${DWM[@]}" "${EXTRAS[@]}" "${NODE[@]}"

# Change the login shell for the user that invoked sudo.
ZSH_PATH="$(command -v zsh)"
if [[ "$TARGET_SHELL" != "$ZSH_PATH" ]]; then
	chsh -s "$ZSH_PATH" "$TARGET_USER"
fi

# Make dash a default shell
ln -sfT dash /usr/bin/sh

install -d -o "$TARGET_USER" -g "$TARGET_GROUP" "$CODE_DIR"

install_git_project opendwm https://github.com/michalorman/opendwm.git
install_git_project dmenu https://github.com/michalorman/dmenu.git

systemctl enable NetworkManager
systemctl enable cups
systemctl enable fstrim.timer

# Enable paccache to cleanup pacman cache
systemctl enable paccache.timer
