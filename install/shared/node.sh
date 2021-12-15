header1 "Installing toolchain for node ${Green}${Color_Off}"

if [ ! $(which volta) ]; then
  curl https://get.volta.sh | bash
  volta install node
fi

