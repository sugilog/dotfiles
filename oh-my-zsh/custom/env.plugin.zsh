export DISABLE_UPDATE_PROMPT=true
export LESS=R
export SVN_EDITOR=vim
export EDITOR=vim
# export LC_CTYPE=UTF-8

alias mysql="mysql --auto-rehash"
export MYSQL_PS1='\u@\h[\d]> '

if [[ -s $HOME/bin ]]; then
  export PATH="$HOME/bin:$PATH"
fi

if [[ -s $HOME/.rbenv ]]; then
  export PATH="$HOME/.rbenv/bin:$PATH"
  eval "$(rbenv init -)"
else
  which rbenv > /dev/null 2>&1
  if [[ "$?" = "0" ]]; then
    export PATH="$HOME/.rbenv/bin:$PATH"
    eval "$(rbenv init -)"
  fi
fi

if [[ -s $HOME/.nodenv ]]; then
  export PATH="$HOME/.nodenv/bin:$PATH"
  eval "$(nodenv init -)"
else
  which nodenv > /dev/null 2>&1
  if [[ "$?" = "0" ]]; then
    export PATH="$HOME/.nodenv/bin:$PATH"
    eval "$(nodenv init -)"
  fi
fi

if [[ -s $HOME/.goenv ]]; then
  export GOENV_ROOT="$HOME/.goenv"
  export GOPATH=$HOME/go
  export PATH="$GOENV_ROOT/bin:$GOPATH/bin:$PATH"
  eval "$(goenv init -)"
else
  which goenv > /dev/null 2>&1
  if [[ "$?" = "0" ]]; then
    export GOENV_ROOT="$HOME/.goenv"
    export GOPATH=$HOME/go
    export PATH="$GOENV_ROOT/bin:$GOPATH/bin:$PATH"
    eval "$(goenv init -)"
  fi
fi

if [[ -s $HOME/.vimenv ]]; then
  export PATH="$HOME/.vimenv/bin:$PATH"
  eval "$(vimenv init -)"
else
  which vimenv > /dev/null 2>&1
  if [[ "$?" = "0" ]]; then
    export PATH="$HOME/.vimenv/bin:$PATH"
    eval "$(vimenv init -)"
  fi
fi

which direnv > /dev/null 2>&1
if [[ "$?" = "0" ]]; then
  eval "$(direnv hook zsh)"
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

if [[ -s $GOPATH/bin/salias ]]; then
  export SALIAS_PATH=$HOME/dotfiles/salias.toml
  source <(salias --init)
fi

if [[ -s /home/linuxbrew/.linuxbrew ]] ; then
  eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
fi
