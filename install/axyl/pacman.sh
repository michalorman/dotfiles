header1 "Updating system packages"

sudo pacman -Syu --noconfirm

packages=( \
  fzf the_silver_searcher ripgrep aws-cli fd zoxide bpytop \
  flatpak rust-analyzer
)

sudo pacman -S ${packages[*]} --noconfirm

source install/shared/yay.sh

yay -Syu --devel
