if [ ! "$(which starship)" ]; then
	header2 "installing Starship 🚀"

	sh -c "$(curl -fsSL https://starship.rs/install.sh)"
fi
