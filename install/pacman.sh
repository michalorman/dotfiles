header1 "Installing packages..."

pacman_install() {
	pacman -Sq --noconfirm $1
}

pacman_install neovim
pacman_install tmux
