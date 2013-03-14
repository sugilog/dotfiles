function chpwd() {
  ls -la

  if [ -d ".svn" ]; then
    echo "\nsvn info\n`svn info`"
  fi

  _reg_pwd_screennum
}

# XXX: use tmuxinator
# if [ ${TERM} = "xterm-color" ]; then
#   case "${OSTYPE}" in
#   freebsd*|darwin*)
#     which tmux
#     if [ "$?" -eq 0 ]; then
#       tmux -u
#     fi
#   esac
# fi

case "${OSTYPE}" in
freebsd*|darwin*)
  # http://d.hatena.ne.jp/zariganitosh/20110614/release_memory_no_swap
  libera_memory() {
    du -sx / >& /dev/null & sleep 5 && kill $!
    diskutil repairPermissions /
    purge
  }

  mi() {
    open $@ -a /Applications/mi.app
  }

  vij() {
    vim `date +%Y%m.md`
  }
  ;;
esac

viack() {
  vim `ack $@ -l`
}
viag() {
  vim `ag $@ -l`
}

sd() {
  svn diff $@ | colordiff | less
}

