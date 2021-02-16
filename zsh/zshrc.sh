# https://scriptingosx.com/2019/07/moving-to-zsh-06-customizing-the-zsh-prompt/
PROMPT='%B%2~ %f%b%# '

export DOTFILES=$HOME/Code/dotfiles

for config in $DOTFILES/zsh/conf/*.sh; do
  source $config
done

# https://github.com/git/git/blob/master/contrib/completion/git-prompt.sh
GIT_PROMPT_FILE=$DOTFILES/zsh/git-prompt.sh

if [ -f "$GIT_PROMPT_FILE" ]; then
	source $GIT_PROMPT_FILE

	setopt prompt_subst
	RPROMPT='%F{240}$(__git_ps1 " (%s)")'
fi

VOLTA_HOME="$HOME/.volta"

if [ -f "$VOLTA_HOME" ]; then
	export $VOLTA_HOME
	export PATH="$VOLTA_HOME/bin:$PATH"
fi

[ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh