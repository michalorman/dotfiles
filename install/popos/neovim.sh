header1 "Installing neovim ${Green}${Color_Off}"

if [ ! "$(which nvim)" ]; then

  sudo add-apt-repository ppa:neovim-ppa/unstable
  sudo apt update
  sudo apt install neovim -y
fi

# Post install
if [ ! -f $HOME/Code/dotfiles/nvim/autoload/plug.vim ]; then
	curl -fLo $HOME/Code/dotfiles/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi
