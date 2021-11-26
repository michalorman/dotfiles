header1 "Installing packages..."

pacman_install() {
	pacman -Sq --noconfirm $1
}

pacman -Syu --noconfirm

pacman_install neovim
pacman_install tmux
pacman_install otf-nerd-fonts-fira-code
