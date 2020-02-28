export DISABLE_UPDATE_PROMPT=true
export LESS=R
export SVN_EDITOR=nvim
export EDITOR=nvim

alias mysql="mysql --auto-rehash"
export MYSQL_PS1='\u@\h[\d]> '

export AWS_PAGER=""

export PATH=`echo $PATH | sed -e "s/:\/Applications\/VMware Fusion.app\/Contents\/Public:/:/g"`

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

which brew > /dev/null 2>&1
if [[ "$?" = "0" ]]; then
  export PATH="/usr/local/sbin:$PATH"
  export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl)"
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
  export PATH="${GOPATH}/bin:$PATH"
else
  which goenv > /dev/null 2>&1
  if [[ "$?" = "0" ]]; then
    export GOENV_ROOT="$HOME/.goenv"
    export GOPATH=$HOME/go
    export PATH="$GOENV_ROOT/bin:$GOPATH/bin:$PATH"
    eval "$(goenv init -)"
    export PATH="${GOPATH}/bin:$PATH"
  fi
fi

if [[ -s $HOME/.pyenv ]]; then
  export PYENV_ROOT="$HOME/.pyenv"
  export PATH="$PYENV_ROOT/bin:$PATH"
  export VIRTUAL_ENV_DISABLE_PROMPT=1
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"
else
  which pyenv > /dev/null 2>&1
  if [[ "$?" = "0" ]]; then
    export PYENV_ROOT="$HOME/.pyenv"
    export PATH="$PYENV_ROOT/bin:$PATH"
    export VIRTUAL_ENV_DISABLE_PROMPT=1
    eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init -)"
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
