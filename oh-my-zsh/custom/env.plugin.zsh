export LESS=R
export SVN_EDITOR=vim
export EDITOR=vim

alias mysql="mysql --auto-rehash"
export MYSQL_PS1='\u@\h[\d]> '

#if [[ -s $HOME/.rvm/scripts/rvm ]] ; then source $HOME/.rvm/scripts/rvm ; fi
if [[ -s $HOME/.rbenv ]]; then
  export PATH="$HOME/.rbenv/bin:$PATH"
  eval "$(rbenv init -)"
fi

# check tmuxinator env: tmuxinator doctor
if [[ -s $HOME/.tmuxinator/scripts/tmuxinator ]] ; then
  source $HOME/.tmuxinator/scripts/tmuxinator;
fi

