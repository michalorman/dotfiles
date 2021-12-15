header1 "Updating system packages"

sudo pacman -Syu --noconfirm

packages=( \
  fzf the_silver_searcher ripgrep aws-cli fd zoxide bpytop \
  flatpak
)

sudo pacman -S ${packages[*]} --noconfirm
