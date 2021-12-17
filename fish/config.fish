# stuff that comes with Garuda by default
# source $HOME/Code/dotfiles/fish/defaults.fish # TODO: move to garuda specific install

source $HOME/Code/dotfiles/fish/aliases.fish

set -gx VOLTA_HOME "$HOME/.volta"
set -gx PATH "$VOLTA_HOME/bin" $PATH

[ -f $HOME/.cargo/env ]; and source $HOME/.cargo/env

if status --is-interactive
  if type -q starship
    starship init fish | source
  end

  # if type -q neofetch
  #   neofetch
  # end

  if type -q colorscript
    colorscript -r
  end

  if type -q zoxide
    zoxide init fish | source
  end
end
