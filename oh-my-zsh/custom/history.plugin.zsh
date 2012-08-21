HISTFILE=~/.zsh_histfile

if [ $UID = 0 ]; then
  unset HISTFILE
  SAVEHIST=0
fi

setopt share_history
setopt hist_ignore_all_dups
setopt hist_ignore_dups
setopt hist_save_no_dups
