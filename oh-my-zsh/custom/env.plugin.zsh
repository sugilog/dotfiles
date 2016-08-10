export DISABLE_UPDATE_PROMPT=true
export LESS=R
export SVN_EDITOR=vim
export EDITOR=vim
# export LC_CTYPE=UTF-8

alias mysql="mysql --auto-rehash"
export MYSQL_PS1='\u@\h[\d]> '

if [[ -s $HOME/.rbenv ]]; then
  export PATH="$HOME/.rbenv/bin:$PATH"
  eval "$(rbenv init -)"
fi

if [[ -s $HOME/.nodenv ]]; then
  export PATH="$HOME/.nodenv/bin:$PATH"
  eval "$(nodenv init -)"
else
  which nodenv
  if [[ "$?" = "0" ]]; then
    eval "$(nodenv init -)"
  fi
fi

# check tmuxinator env: tmuxinator doctor
if [[ -s $HOME/.tmuxinator/scripts/tmuxinator ]] ; then
  source $HOME/.tmuxinator/scripts/tmuxinator;
fi

if [[ -s /usr/local/heroku/bin ]] ; then
  export PATH="/usr/local/heroku/bin:$PATH"
fi

if [[ -s /usr/local/share/npm/bin ]] ; then
  export PATH="/usr/local/share/npm/bin:$PATH"
fi
