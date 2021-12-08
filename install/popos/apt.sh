header1 "Updating apt packages"

sudo apt update -y && sudo apt upgrade -y

packages=(fish alacritty silversearcher-ag tmux fzf autojump ripgrep awscli obs-studio preload neofetch)

sudo apt install -qq ${packages[*]}
sudo apt autoremove -qq
