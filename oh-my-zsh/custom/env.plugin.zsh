export LESS=R
export SVN_EDITOR=vim
export EDITOR=vim

alias mysql="mysql --auto-rehash"
export MYSQL_PS1='\u@\h[\d]> '

if [[ -s $HOME/.rvm/scripts/rvm ]] ; then source $HOME/.rvm/scripts/rvm ; fi

# check tmuxinator env: tmuxinator doctor
[[ -s $HOME/.tmuxinator/scripts/tmuxinator ]] && source $HOME/.tmuxinator/scripts/tmuxinator
