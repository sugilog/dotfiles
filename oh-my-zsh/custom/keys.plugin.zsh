# alias

setopt no_complete_aliases

case "${OSTYPE}" in
freebsd*|darwin*)
alias ls="ls -G -w"
;;
linux*)
alias ls="ls -v -F --color"
;;
esac

alias ll="ls -lah"
alias cp="cp -i"
alias mv="mv -i"
alias rm="rm -i"
alias locate="locate -i"
alias du="du -h"
alias df="df -h"
alias vi="vim"

alias sc="ruby script/console"
alias ss="ruby script/console --sandbox"
alias db="ruby script/dbconsole"
alias g="git"
# need to install colordiff
# http://www.colordiff.org/
# just do: sudo make install
alias diff="colordiff"

alias sudo="sudo env PATH=$PATH"

alias -g M="\`svn st | egrep '^(M|A)' | awk '{print \$2}'\`"
# for rails test with failfast runner
alias -g FF="-r failfast"

alias mongod="mongod --dbpath $HOME/.mongo/data/ --port 27017"
alias tmux="tmux -u"

alias cdd="jump"

alias -g L="2>&1 | less"

# key binds

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


