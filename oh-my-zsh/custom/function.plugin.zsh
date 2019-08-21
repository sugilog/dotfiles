viag() {
  nvim `ag $@ -l`
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

function pet-search() {
  BUFFER=$(pet search --query "$LBUFFER")
  CURSOR=$#BUFFER
  zle redisplay
}

function escape_whitespace ()
{
  sed 's/ /\\ /g'
}

function p ()
{
  case $1 in
    t*)
      cd $(find ~/TIL/* -type d -depth 1 | grep -v "/archives/" | peco)
      ;;
    g*)
      cd $(ghq root)/$(ghq list | peco)
      ;;
    *)
      p $(echo "til\nghq" | peco)
  esac
}
