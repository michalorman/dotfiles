header2 "Configuring neovim:"

symlink $HOME/Code/dotfiles/nvim $HOME/.config/nvim

if [ ! -f $HOME/Code/dotfiles/nvim/autoload/plug.vim ]; then
	curl -fLo $HOME/Code/dotfiles/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

header2 "🍺 neovim configuration done."
