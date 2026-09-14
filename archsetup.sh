#!/bin/bash

set -euo pipefail

BOOTSTRAP=(base-devel git linux-headers sudo)
DESKTOP=(alacritty ffmpegthumbnailer ghostty hyprland j4-dmenu-desktop libgsf libnotify mako networkmanager pacman-contrib playerctl pavucontrol quickshell swaybg swayimg swaylock thunar tumbler udiskie ueberzugpp xdg-desktop-portal-hyprland xdg-utils xorg-xwayland)
CLI_TOOLS=(bat btop dash dua-cli eza fd fzf jq less man most neovim openssh ripgrep tree-sitter-cli vim wl-clipboard yazi zoxide)
MEDIA=(ffmpeg grim gpu-screen-recorder imagemagick resvg slurp swappy vlc vlc-plugin-ffmpeg)
AUDIO=(pipewire pipewire-alsa pipewire-pulse wireplumber)
PRINTING=(cups cups-pdf sane-airscan simple-scan system-config-printer)
FONTS=(noto-fonts-emoji ttf-jetbrains-mono-nerd ttf-font-nerd)
SHELL=(dash zsh zsh-syntax-highlighting zsh-completions zsh-autosuggestions)
DMENU_BUILD=(libx11 libxft libxinerama)
DEVELOPMENT=(lua luarocks lsof sassc)
AMD_GRAPHICS=(amd-ucode lib32-mesa lib32-vulkan-radeon libva-utils linux-firmware mesa mesa-utils nvtop radeontop vdpauinfo vulkan-radeon vulkan-tools)
NODE=(nodejs npm)
AUR_TOOLS=(cliamp herdr voxtype)

OPENDWM_REVISION=0591120fc648c5499f38e9bb76cc71c91bf23816
DMENU_REVISION=ce16f01a5637ebe604a7ee9d714b2715cc3f0e71
TOKYONIGHT_GTK_REVISION=6c340e058e84c1975a038a8e5d1e384477225dc0

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
TARGET_UID="$(id -u "$TARGET_USER")"
TARGET_GROUP="$(id -gn "$TARGET_USER")"
TARGET_RUNTIME_DIR="/run/user/$TARGET_UID"
CODE_DIR="$TARGET_HOME/Code"

if [[ "$TARGET_USER" == "root" ]]; then
	printf 'Run this script through sudo from the intended desktop user.\n' >&2
	exit 1
fi
if [[ ! -d "$TARGET_RUNTIME_DIR" || "$(stat -c %u "$TARGET_RUNTIME_DIR")" != "$TARGET_UID" ]]; then
	printf 'Desktop user runtime directory is unavailable: %s\n' "$TARGET_RUNTIME_DIR" >&2
	printf "Run this script from the desktop user's active login session.\n" >&2
	exit 1
fi

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

github_repo_path() {
	local url="$1"
	case "$url" in
		https://github.com/*) printf '%s' "${url#https://github.com/}" ;;
		git@github.com:*) printf '%s' "${url#git@github.com:}" ;;
		*) return 1 ;;
	esac
}

origins_match() {
	local actual="$1"
	local expected="$2"
	local actual_path
	local expected_path

	actual_path="$(github_repo_path "$actual" 2>/dev/null || true)"
	expected_path="$(github_repo_path "$expected" 2>/dev/null || true)"
	[[ -n "$actual_path" && "${actual_path%.git}" == "${expected_path%.git}" ]]
}

checkout_git_project() {
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
		if ! origins_match "$(run_as_target_user git -C "$repo_dir" remote get-url origin)" "$repo_url"; then
			printf 'Refusing to use %s because its origin does not match %s.\n' "$repo_dir" "$repo_url" >&2
			return 1
		fi
	fi
	run_as_target_user git -C "$repo_dir" fetch --depth 1 origin "$revision"
	run_as_target_user git -C "$repo_dir" checkout --detach "$revision"
}

install_dmenu() {
	local repo_dir="$CODE_DIR/dmenu"

	checkout_git_project dmenu https://github.com/michalorman/dmenu.git "$DMENU_REVISION"

	if [[ ! -f "$repo_dir/config.h" ]]; then
		run_as_target_user cp "$repo_dir/config.def.h" "$repo_dir/config.h"
	else
		printf 'dmenu config.h already exists; leaving it unchanged.\n'
	fi

	run_as_target_user make -C "$repo_dir"
	make -C "$repo_dir" PREFIX=/usr/local install
}

install_opendwm_wayland() {
	local repo_dir="$CODE_DIR/opendwm"
	local hyprland_config="$repo_dir/wayland/hyprland/hyprland.lua"

	checkout_git_project opendwm https://github.com/michalorman/opendwm.git "$OPENDWM_REVISION"
	if ! run_as_target_user grep -Fqx '    hl.exec_cmd("dunst")' "$hyprland_config"; then
		printf 'Expected Dunst autostart command is unavailable: %s\n' "$hyprland_config" >&2
		return 1
	fi
	run_as_target_user sed -i 's/hl\.exec_cmd("dunst")/hl.exec_cmd("mako")/' "$hyprland_config"
	run_as_target_user env \
		XDG_CONFIG_HOME="$TARGET_HOME/.config" \
		XDG_RUNTIME_DIR="$TARGET_RUNTIME_DIR" \
		PATH="$TARGET_HOME/.local/bin:/usr/local/bin:/usr/bin:/bin" \
		/usr/bin/bash "$repo_dir/wayland/setup.sh" --force
	run_as_target_user env \
		XDG_CONFIG_HOME="$TARGET_HOME/.config" \
		XDG_RUNTIME_DIR="$TARGET_RUNTIME_DIR" \
		PATH="$TARGET_HOME/.local/bin:/usr/local/bin:/usr/bin:/bin" \
		/usr/bin/bash "$repo_dir/wayland/setup.sh" --check
}

install_tokyonight_gtk() {
	local repo_dir="$CODE_DIR/tokyonight-gtk-theme"

	checkout_git_project tokyonight-gtk-theme https://github.com/Fausto-Korpsvart/Tokyonight-GTK-Theme.git "$TOKYONIGHT_GTK_REVISION"
	run_as_target_user env \
		XDG_DATA_HOME="$TARGET_HOME/.local/share" \
		/usr/bin/bash "$repo_dir/themes/install.sh" \
		--dest "$TARGET_HOME/.local/share/themes" \
		--theme default \
		--color dark \
		--size standard
	run_as_target_user install -d "$TARGET_HOME/.local/share/icons"
	run_as_target_user cp -a "$repo_dir/icons/Tokyonight-Dark" "$TARGET_HOME/.local/share/icons/"
}

verify_executable() {
	if [[ ! -x "$1" ]]; then
		printf 'Expected executable is unavailable: %s\n' "$1" >&2
		return 1
	fi
}

PACKAGES=("${BOOTSTRAP[@]}" "${DESKTOP[@]}" "${CLI_TOOLS[@]}" "${MEDIA[@]}" "${AUDIO[@]}" "${FONTS[@]}" "${SHELL[@]}" "${DMENU_BUILD[@]}" "${DEVELOPMENT[@]}")

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

install_dmenu
install_opendwm_wayland
install_tokyonight_gtk

systemctl enable NetworkManager
systemctl enable fstrim.timer
systemctl enable paccache.timer

if (( INSTALL_ALL || INSTALL_PRINTING )); then
	systemctl enable cups
fi

verify_executable /usr/local/bin/dmenu
verify_executable /usr/local/bin/start-opendwm-wayland
if [[ ! -r /usr/share/wayland-sessions/opendwm-wayland.desktop ]]; then
	printf 'Expected Wayland session entry is unavailable.\n' >&2
	exit 1
fi
verify_executable /usr/bin/swaylock
verify_executable /usr/bin/slurp
verify_executable /usr/bin/wpctl

printf 'Install AUR tools separately: %s\n' "${AUR_TOOLS[*]}"
