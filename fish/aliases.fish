alias gst='git status'
alias glo='git log'
alias glr='git log -n 30'
alias ga='git add'
alias grbm='git rebase master'
alias grbim='git rebase -i master'
alias gci='git commit'
alias gbr='git branch'
alias gdi='git difftool'
alias gdiff='git difftool'
alias gd='git diff'
alias gco='git checkout'
alias gcm='git checkout master'
alias gp='git push'
alias gl='git pull'

alias ss='ruby -run -e httpd -- -p 5000 .'

alias tmux='tmux -2'
alias ts='tmux new -s (basename $PWD)'
alias tls='tmux ls'

if type -q exa
  alias ls='exa -al --color=always --group-directories-first --icons' # preferred listing
  alias la='exa -a --color=always --group-directories-first --icons'  # all files and dirs
  alias ll='exa -l --color=always --group-directories-first --icons'  # long format
  alias lt='exa -aT --color=always --group-directories-first --icons' # tree listing
  alias l.="exa -a | egrep '^\.'"                                     # show only dotfiles
end

alias untar='tar -zxvf '

if type -q fdfind
  alias fd=fdfind
end
