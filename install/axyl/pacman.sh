header1 "Updating system packages"

packages=( \
  fzf the_silver_searcher ripgrep aws-cli fd zoxide bpytop \
  flatpak rust-analyzer playerctl rofi flameshot docker \
  dash bsp-layout shellcheck
)

sudo pacman -S ${packages[*]} --noconfirm

source install/shared/yay.sh

# yay -Syu --devel
