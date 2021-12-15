header "Configuring axyl! ..."

[ $(which neofetch) ] && neofetch -L

source install/axyl/pacman.sh
source install/shared/starship.sh
source install/shared/node.sh

# Backup original configuration
confs=(nvim fish)

for conf in "${confs[@]}"; do
  if [ ! -d "$HOME/.config/$conf.orig" ]; then
    echo "backing up $HOME/.config/$conf"
    mv $HOME/.config/$conf $HOME/.config/$conf.orig
  fi
done

header1 "executing dotbot-install"
source dotbot-install

footer "axyl configured!"
