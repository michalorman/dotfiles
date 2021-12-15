if [ ! $(which starship) ]; then
  header1 "Updating starship"

  sh -c "$(curl -fsSL https://starship.rs/install.sh)"
fi
