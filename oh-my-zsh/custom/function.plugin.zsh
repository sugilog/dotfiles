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

function pet-search() {
  BUFFER=$(pet search --query "$LBUFFER")
  CURSOR=$#BUFFER
  zle redisplay
}
