header1 "Updating flatpak packages"

packs=(slack spotify mailspring joplin dropbox planner fragments)

flatpak install ${packs[*]} -y
