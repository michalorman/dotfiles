header1 "Updating apt packages"

sudo apt update -y && sudo apt upgrade -y

packages=( \
fish alacritty silversearcher-ag tmux \
fzf ripgrep awscli obs-studio preload \
neofetch exa fd-find zoxide htop bpytop \
ubuntu-restricted-extras)

sudo apt install -qq -y ${packages[*]}
sudo apt autoremove -qq -y
