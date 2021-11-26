header1 "Installing packages..."

pacman_install() {
	sudo pacman -Sq --noconfirm $1
}

sudo pacman -Syu --noconfirm

pacman_install neovim
pacman_install tmux
pacman_install fzf
pacman_install autojump
pacman_install ripgrep
pacman_install the_silver_searcher
pacman_install nerd-fonts-fira-code
pacman_install fd
