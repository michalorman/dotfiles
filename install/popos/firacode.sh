if [ ! "$(fc-list | grep "FiraCode Nerd")" ]; then
	header2 "installing FiraCode Nerd Font"

	[ ! -d $HOME/.fonts ] && mkdir $HOME/.fonts

	curl -fLo /tmp/FiraCode.zip https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/FiraCode.zip
	unzip -o /tmp/FiraCode.zip -d /tmp/FiraCode
	cp /tmp/FiraCode/* $HOME/.fonts
	sudo fc-cache -fv
fi
