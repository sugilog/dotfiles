function chpwd() {
  ls -la

  if [ -d ".svn" ]; then
    echo "\nsvn info\n`svn info`"
  fi

  _reg_pwd_screennum
}

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


# http://unix.stackexchange.com/questions/41980/prevent-watch-breaking-colors
function watcher()
{
  WATCHERTIME=$1
  WATCHERFILE=/tmp/watcher$$
  shift
  while true; do
    WATCHERHEIGHT=$(($LINES - 5))
    ( eval $* ) | tail -n ${WATCHERHEIGHT} > ${WATCHERFILE} 2>/dev/null
    clear
    /bin/echo -n "Every ${WATCHERTIME} seconds - "
    date
    /bin/echo
    cat ${WATCHERFILE}
    \rm -f ${WATCHERFILE}
    /bin/echo
    /bin/echo "=="
    sleep ${WATCHERTIME}
  done
}
