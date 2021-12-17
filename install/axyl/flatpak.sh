header1 "Installing / updating flatpak packages"

packs=( \
  slack spotify joplin dropbox \
)

flatpak install ${packs[*]} -y
