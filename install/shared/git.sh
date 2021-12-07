header2 "Configuring git:"

for file in $HOME/Code/dotfiles/git/*; do
  symlink $file $HOME/.$(basename $file)
done

header2 "🍺 git configuration done."
