##################################################
### basic options
##################################################
zstyle :compinstall filename '~/.zshrc'
autoload -Uz compinit
compinit

setopt auto_cd
setopt auto_pushd
setopt pushd_ignore_dups
setopt correct
setopt auto_param_keys

setopt auto_menu

setopt list_packed

zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin \
 /usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*:default' menu select


##################################################
### prompt color settings
##################################################
autoload -Uz colors
colors

setopt prompt_subst

case ${UID} in
  0)
  PROMPT="%{$fg_bold[green]%}%m%{$fg_bold[red]%}#%{$reset_color%} "
  PROMPT2="%{$fg[magenta]%}%_%{$reset_color%}%{$fg_bold[white]%}>>%{$reset_color%} "
  ;;
  *)
  PROMPT="%{$fg_bold[cyan]%}%m%{$fg_bold[white]%}%%%{$reset_color%} "
  PROMPT2="%{$fg[magenta]%}%_%{$reset_color%}%{$fg_bold[white]%}>>%{$reset_color%} "
  ;;
esac

RPROMPT="%{$fg_bold[white]%}[%{$reset_color%}%{$fg[cyan]%}%~%{$reset_color%}%{$fg_bold[white]%}]%{$reset_color%} "
SPROMPT="%{$fg_bold[red]%}correct%{$reset_color%}: %R -> %r ? "

case "${OSTYPE}" in
freebsd*|darwin*)
export LSCOLORS=ExFxCxdxBxegedabagacad
export LS_COLORS='di=01;34:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
export ZLS_COLORS=$LS_COLORS
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
;;
linux*)
zstyle ':completion:*' list-colors di=34 fi=0
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
;;
esac


##################################################
### settings
##################################################
source $HOME/dotfiles/oh-my-zsh/custom/basic.plugin.zsh
source $HOME/dotfiles/oh-my-zsh/custom/history.plugin.zsh
source $HOME/dotfiles/oh-my-zsh/custom/keys.plugin.zsh
source $HOME/dotfiles/oh-my-zsh/custom/function.plugin.zsh
source $HOME/dotfiles/oh-my-zsh/custom/env.plugin.zsh
