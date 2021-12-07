header2 "Configuring fish..."

symlink $HOME/Code/dotfiles/fish/config.fish $HOME/.config/fish/config.fish

if [ "$(basename $SHELL)" != "fish" ]; then
  header2 "Changing shell to fish"
  chsh -s /usr/bin/fish
fi

header2 "🍺 fish configuration done."
