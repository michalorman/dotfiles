sudo pacman -S --needed git base-devel

aur_makepkg() {
  curwd=pwd
  git clone $1 $HOME/Code/$2 
  cd $HOME/Code/$2
  makepkg -si
  cd $curwd
}
