if [ ! "$(which nvim)" ]; then
  header2 "Installing neovim"

  sudo add-apt-repository ppa:neovim-ppa/unstable
  sudo apt update
  sudo apt install neovim -y
fi
