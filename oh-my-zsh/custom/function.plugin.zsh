function chpwd() {
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

function _notify()
{
  if [ $3 != "" ]; then
    ip=`echo $SSH_CONNECTION | awk '{ print $1 }'`
    echo $3
    ssh $1@$ip "growlnotify -t $2 -m '$3' -w"
  fi

}
function fcgi_mem_usage()
{
  ps aux | grep fcgi | grep -v grep | awk '{ print $2","$6 }' | ruby -nle 'pid, mem = $_.split(","); mem.to_i > 1000000 ? (puts "WARN: #{pid}: #{mem}") : nil'
}
function notify_fcgi_mem_usage()
{
  _notify $1 "fcgi mem usage" "`fcgi_mem_usage`"
}
