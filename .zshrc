## refs: special thanx
## http://memo.officebrook.net/20090205.html
## http://d.hatena.ne.jp/j7400157/20080723/1216827182

## auto complete: enable compsys
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

## prompt color settings
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

## history

HISTFILE=~/.zsh_histfile
HISTSIZE=10000
SAVEHIST=10000

if [ $UID = 0 ]; then
 unset HISTFILE
 SAVEHIST=0
fi

setopt share_history
setopt hist_ignore_all_dups
setopt hist_ignore_dups
setopt hist_save_no_dups

## alias
setopt complete_aliases

case "${OSTYPE}" in
freebsd*|darwin*)
alias ls="ls -G -w"
;;
linux*)
alias ls="ls -v -F --color"
;;
esac

alias ll='ls -al'
alias la='ls -A'
alias cp="cp -i"
alias mv="mv -i"
alias rm="rm -i"
alias locate="locate -i"
alias lv="lv -c -T8192"
alias du="du -h"
alias df="df -h"
alias vi="vim"

alias sc="ruby script/console"
alias screen="nocorrect screen"
alias sr="screen"
alias rak="nocorrect rak"
alias g="git"

alias cdrails="cd ~/apps/__rails_1.2.3__"
alias rs='/bin/sh /home/admin/ruby_server.sh'
alias svn_addall="svn st | grep '^?' | awk '{print \$2}' | xargs svn add"
alias viall="svn st | grep '^M' | awk '{print \$2}' | xargs vim"

## key_bind

bindkey -v

zmodload zsh/complist
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char

autoload -Uz history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end
bindkey "^R" history-incremental-search-backward

## function

function chpwd() { ll }

## env

export SVN_EDITOR=vim

case "${TERM}" in
kterm*|xterm*)
  precmd() {
    echo -ne "\033]0;${USER}@${HOST%%.*}:${PWD}\007"
  }
;;
esac
