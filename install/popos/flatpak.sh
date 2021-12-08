header2 "updating flatpak packages"

packs=(slack spotify mailspring joplin dropbox planner)

flatpak install ${packs[*]} -y
