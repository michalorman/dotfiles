# stuff that comes with Garuda by default
source $HOME/Code/dotfiles/fish/defaults.fish

source $HOME/Code/dotfiles/fish/aliases.fish

set -gx VOLTA_HOME "$HOME/.volta"
set -gx PATH "$VOLTA_HOME/bin" $PATH
