#!/bin/bash

set -euo pipefail

BOOTSTRAP=(base-devel git linux-headers)
X11=(xorg-server xorg-xinit xorg-xkill xorg-xmodmap xorg-xrandr xorg-xrdb xorg-setxkbmap)
DESKTOP=(alacritty dunst feh j4-dmenu-desktop lxappearance networkmanager nsxiv pacman-contrib picom playerctl pavucontrol slock thunar udiskie ueberzugpp xdg-utils)
CLI_TOOLS=(bat btop dash dua-cli eza fd fzf jq less man most neovim openssh ripgrep tmux tree-sitter-cli vim yazi zoxide)
MEDIA=(ffmpeg gpu-screen-recorder imagemagick maim resvg slop swappy vlc vlc-plugin-ffmpeg)
AUDIO=(pipewire pipewire-alsa pipewire-pulse wireplumber)
PRINTING=(cups cups-pdf sane-airscan simple-scan system-config-printer)
FONTS=(noto-fonts-emoji ttf-jetbrains-mono-nerd ttf-font-nerd)
SHELL=(dash zsh zsh-syntax-highlighting zsh-completions zsh-autosuggestions)
DWM_BUILD=(libx11 libxft libxinerama)
DEVELOPMENT=(lua luarocks lsof)
AMD_GRAPHICS=(amd-ucode lib32-mesa lib32-vulkan-radeon libva-utils linux-firmware mesa mesa-utils nvtop radeontop vdpauinfo vulkan-radeon vulkan-tools xf86-video-amdgpu)
NODE=(nodejs npm)
AUR_TOOLS=(cliamp voxtype)

OPENDWM_REVISION=db5f1dae2bb83f05754d2d940b506d6b715417af
DMENU_REVISION=ce16f01a5637ebe604a7ee9d714b2715cc3f0e71

usage() {
	printf 'Usage: %s [--amd] [--printing] [--node]\n' "$0"
	printf 'Without profile options, installs every profile.\n'
}

INSTALL_ALL=1
INSTALL_AMD=0
INSTALL_PRINTING=0
INSTALL_NODE=0

if (( $# > 0 )); then
	INSTALL_ALL=0
	for option in "$@"; do
		case "$option" in
			--amd) INSTALL_AMD=1 ;;
			--printing) INSTALL_PRINTING=1 ;;
			--node) INSTALL_NODE=1 ;;
			-h|--help)
				usage
				exit 0
				;;
			*)
				usage >&2
				exit 2
				;;
		esac
	done
fi

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

enable_multilib() {
	if pacman-conf --repo-list | grep -qx multilib; then
		return
	fi

	local pacman_conf=/etc/pacman.conf
	local backup_conf="$pacman_conf.archsetup-backup"
	local tmp_conf
	tmp_conf="$(mktemp "$pacman_conf.XXXXXX")"

	awk '
		BEGIN { in_multilib = 0 }
		/^[[:space:]]*#[[:space:]]*\[multilib\][[:space:]]*$/ {
			print "[multilib]"
			in_multilib = 1
			next
		}
		in_multilib && /^[[:space:]]*#[[:space:]]*Include[[:space:]]*=[[:space:]]*\/etc\/pacman\.d\/mirrorlist[[:space:]]*$/ {
			print "Include = /etc/pacman.d/mirrorlist"
			in_multilib = 0
			next
		}
		in_multilib && /^[[:space:]]*\[/ { in_multilib = 0 }
		{ print }
	' "$pacman_conf" > "$tmp_conf"

	if ! pacman-conf --config "$tmp_conf" --repo-list | grep -qx multilib; then
		rm -f "$tmp_conf"
		printf 'Unable to enable [multilib] in %s. Please enable it manually.\n' "$pacman_conf" >&2
		return 1
	fi

	if [[ ! -e "$backup_conf" ]]; then
		cp -p "$pacman_conf" "$backup_conf"
	fi
	chmod 0644 "$tmp_conf"
	mv -f "$tmp_conf" "$pacman_conf"
}

install_git_project() {
	local name="$1"
	local repo_url="$2"
	local revision="$3"
	local repo_dir="$CODE_DIR/$name"

	if [[ -e "$repo_dir" && ! -d "$repo_dir/.git" ]]; then
		printf 'Refusing to use %s because it exists but is not a git checkout.\n' "$repo_dir" >&2
		return 1
	fi

	if [[ ! -d "$repo_dir" ]]; then
		run_as_target_user git clone "$repo_url" "$repo_dir"
	else
		if [[ "$(run_as_target_user git -C "$repo_dir" remote get-url origin)" != "$repo_url" ]]; then
			printf 'Refusing to use %s because its origin does not match %s.\n' "$repo_dir" "$repo_url" >&2
			return 1
		fi
	fi
	run_as_target_user git -C "$repo_dir" fetch --depth 1 origin "$revision"
	run_as_target_user git -C "$repo_dir" checkout --detach "$revision"

	if [[ ! -f "$repo_dir/config.h" ]]; then
		run_as_target_user cp "$repo_dir/examples/config.h" "$repo_dir/config.h"
	else
		printf '%s config.h already exists; leaving it unchanged.\n' "$name"
	fi

	run_as_target_user make -C "$repo_dir"
	make -C "$repo_dir" install
}

verify_executable() {
	if [[ ! -x "$1" ]]; then
		printf 'Expected executable is unavailable: %s\n' "$1" >&2
		return 1
	fi
}

PACKAGES=("${BOOTSTRAP[@]}" "${X11[@]}" "${DESKTOP[@]}" "${CLI_TOOLS[@]}" "${MEDIA[@]}" "${AUDIO[@]}" "${FONTS[@]}" "${SHELL[@]}" "${DWM_BUILD[@]}" "${DEVELOPMENT[@]}")

if (( INSTALL_ALL || INSTALL_AMD )); then
	enable_multilib
	PACKAGES+=("${AMD_GRAPHICS[@]}")
fi

if (( INSTALL_ALL || INSTALL_PRINTING )); then
	PACKAGES+=("${PRINTING[@]}")
fi

if (( INSTALL_ALL || INSTALL_NODE )); then
	PACKAGES+=("${NODE[@]}")
fi

pacman -Syu --noconfirm --needed "${PACKAGES[@]}"

# Change the login shell for the user that invoked sudo.
ZSH_PATH="$(command -v zsh)"
if [[ "$TARGET_SHELL" != "$ZSH_PATH" ]]; then
	chsh -s "$ZSH_PATH" "$TARGET_USER"
fi

install -d -o "$TARGET_USER" -g "$TARGET_GROUP" "$CODE_DIR"

install_git_project opendwm https://github.com/michalorman/opendwm.git "$OPENDWM_REVISION"
install_git_project dmenu https://github.com/michalorman/dmenu.git "$DMENU_REVISION"

systemctl enable NetworkManager
systemctl enable fstrim.timer
systemctl enable paccache.timer

if (( INSTALL_ALL || INSTALL_PRINTING )); then
	systemctl enable cups
fi

verify_executable /usr/local/bin/dmenu
verify_executable /usr/local/bin/opendwm
verify_executable /usr/bin/slock
verify_executable /usr/bin/slop
verify_executable /usr/bin/wpctl

printf 'Install AUR tools separately: %s\n' "${AUR_TOOLS[*]}"
