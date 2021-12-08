header1 "Updating flatpak packages"

packs=(slack spotify mailspring joplin dropbox planner)

flatpak install ${packs[*]} -y
