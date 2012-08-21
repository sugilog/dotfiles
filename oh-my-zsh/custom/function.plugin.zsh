function chpwd() {
  ls -la

  if [ -d ".svn" ]; then
    echo "\nsvn info\n`svn info`"
  fi

  _reg_pwd_screennum
}

if [ ${TERM} != "screen" ]; then
  case "${OSTYPE}" in
  freebsd*|darwin*)
    ;;
  *)
    which screen
    if [ "$?" -eq 0 ]; then
      if [ $TERM != "linux" ]; then
        screen
      fi
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
