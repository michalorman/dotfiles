header1 "Configuring fish ${Green}${Color_Off}"

symlink $HOME/Code/dotfiles/fish/config.fish $HOME/.config/fish/config.fish

if [ "$(basename $SHELL)" != "fish" ]; then
  header2 "Changing shell to fish"
  chsh -s /usr/bin/fish
fi

"$(curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher)"

# if [ ! "$(which fisher)" ]; then
#   curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher
# fi

# fisher update

# fisher install jethrokuan/z
