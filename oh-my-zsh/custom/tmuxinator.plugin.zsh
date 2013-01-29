# http://clauswitt.com/tmuxinator-zsh-completion.html
#
_mux() {
  compadd `mux list | grep -v "tmuxinator" | sed -e 's/^[ \t]*//'`
}

compdef _mux mux
