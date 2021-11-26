header1 "Installing node..."

curl https://get.volta.sh | bash

if [ -x $HOME/.volta/bin/volta ]; then
  volta install node
fi

