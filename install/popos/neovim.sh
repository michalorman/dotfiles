if [ ! "$(which nvim)" ]; then
  header1 "Installing neovim ${Green}${Color_Off}"

  sudo add-apt-repository ppa:neovim-ppa/unstable
  sudo apt update
  sudo apt install neovim -y
fi
