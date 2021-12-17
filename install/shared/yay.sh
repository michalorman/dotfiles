source lib/arch_helpers.sh

if [ ! $(which yay)]; then
  header1 "Installing yay!"

  aur_makepkg https://aur.archlinux.org/yay.git yay
fi
