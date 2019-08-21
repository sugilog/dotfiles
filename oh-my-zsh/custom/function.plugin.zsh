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
  local filter=$2

  case $1 in
    # til
    t*)
      local d=$(find $(ghq root)/github.com/sugilog/TIL/* -type d -depth 1 | grep -v "/archives/" | grep -i "$filter" | peco --select-1)
      echo "cd $d"
      cd $d
      ;;
    # ghq
    g*)
      local d=$(ghq root)/$(ghq list | grep -i "$filter" | peco --select-1)
      echo "cd $d"
      cd $d
      ;;
    # current
    c*)
      local d=$(find $HOME/apps -maxdepth 1 -mindepth 1 -type d | peco --select-1)/current
      echo "cd $d"
      cd $d
      ;;
    *)
      p $(echo "til\nghq\ncurrent" | peco)
  esac
}
