header2 "updating apt packages"

sudo apt update -y && sudo apt upgrade -y

packages=(fish alacritty silversearcher-ag tmux fzf autojump ripgrep awscli obs-studio preload neofetch)

sudo apt install -y ${packages[*]}
