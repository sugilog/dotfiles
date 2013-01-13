function chpwd() {
  ls -la

  if [ -d ".svn" ]; then
    echo "\nsvn info\n`svn info`"
  fi

  _reg_pwd_screennum
}

if [ ${TERM} = "xterm-color" ]; then
  case "${OSTYPE}" in
  freebsd*|darwin*)
    which tmux
    if [ "$?" -eq 0 ]; then
      tmux -u
    fi
  esac
fi

# http://d.hatena.ne.jp/zariganitosh/20110614/release_memory_no_swap
case "${OSTYPE}" in
freebsd*|darwin*)
  libera_memory() {
    du -sx / >& /dev/null & sleep 5 && kill $!
    diskutil repairPermissions /
    purge
  }
  ;;
esac

viack() {
  vim `ack $@ -l`
}

sd() {
  svn diff $@ | colordiff | less
}

vij() {
  vim `date +%Y%m.md`
}
