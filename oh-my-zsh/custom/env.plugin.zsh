export DISABLE_UPDATE_PROMPT=true
export LESS=R
export SVN_EDITOR=vim
export EDITOR=vim

alias mysql="mysql --auto-rehash"
export MYSQL_PS1='\u@\h[\d]> '

if [[ -s $HOME/.rbenv ]]; then
  export PATH="$HOME/.rbenv/bin:$PATH"
  eval "$(rbenv init -)"
fi

# check tmuxinator env: tmuxinator doctor
if [[ -s $HOME/.tmuxinator/scripts/tmuxinator ]] ; then
  source $HOME/.tmuxinator/scripts/tmuxinator;
fi

if [[ -s $HOME/dotfiles/powerline/scripts ]] ; then
  PATH=$HOME/dotfiles/powerline/scripts:$PATH
  . $HOME/dotfiles/powerline/powerline/bindings/zsh/powerline.zsh
fi

if [[ -s /usr/local/heroku/bin ]] ; then
  export PATH="/usr/local/heroku/bin:$PATH"
fi

if [[ -s /usr/local/share/npm/bin ]] ; then
  export PATH="/usr/local/share/npm/bin:$PATH"
fi
