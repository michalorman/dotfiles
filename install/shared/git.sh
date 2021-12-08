header1 "Configuring git ${Red}${Color_Off}"

for file in $HOME/Code/dotfiles/git/*; do
  symlink $file $HOME/.$(basename $file)
done
