export LESS=R
export SVN_EDITOR=vim
export EDITOR=vim

alias mysql="mysql --auto-rehash"
export MYSQL_PS1='\u@\h[\d]> '

export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

# check tmuxinator env: tmuxinator doctor
[[ -s $HOME/.tmuxinator/scripts/tmuxinator ]] && source $HOME/.tmuxinator/scripts/tmuxinator
