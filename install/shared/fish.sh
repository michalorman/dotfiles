header1 "Configuring fish ${Green}${Color_Off}"

symlink $HOME/Code/dotfiles/fish/config.fish $HOME/.config/fish/config.fish

if [ "$(basename $SHELL)" != "fish" ]; then
  header2 "Changing shell to fish"
  chsh -s /usr/bin/fish
fi
