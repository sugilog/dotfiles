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
  local pre=""
  local dir=""

  case $1 in
    # til
    t*)
      dir=$(find $(ghq root)/github.com/sugilog/TIL/* -type d -depth 1 | grep -v "/archives/" | grep -i "$filter" | peco --select-1)
      ;;
    # ghq
    g*)
      pre=$(ghq root)/;
      dir=$(ghq list | grep -i "$filter" | peco --select-1)
      ;;
    # current
    c*)
      dir=$(find $HOME/apps -maxdepth 1 -mindepth 1 -type d | peco --select-1)/current
      ;;
    *)
      p $(echo "til\nghq\ncurrent" | peco)
  esac

  if [ "${dir}" = "" ]
  then
    return 1
  else
    echo "cd ${pre}${dir}"
    cd ${pre}${dir}
  fi
}
