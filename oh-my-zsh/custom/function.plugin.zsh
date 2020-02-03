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
  local selecttype="dir"
  local pre=""
  local selection=""

  case $1 in
    # til
    t*)
      selection=$(find $(ghq root)/github.com/sugilog/TIL/* -type d -depth 1 | grep -v "/archives/" | grep -i "$filter" | peco --select-1)
      ;;
    # ghq
    g*)
      pre=$(ghq root)/;
      selection=$(ghq list | grep -i "$filter" | peco --select-1)
      ;;
    # tmux panes
    p*)
      selection=$(tmux list-panes -s -F "#{pane_current_path}" | sort | uniq | grep -i "$filter" | peco --select-1)
      ;;
    # current
    c*)
      selection=$(find $HOME/apps -maxdepth 1 -mindepth 1 -type d | peco --select-1)/current
      ;;
    # aws profile
    a*)
      selection=$(cat ~/.aws/credentials ~/.aws/config | grep -e "^\[.*\]" | sed -e "s/profile *//g" | tr "[]" "  " | awk '{ print $1 }' | sort | uniq | grep -i "$filter" | peco --select-1)
      selecttype="aws"
      ;;
    *)
      p $(echo "til\nghq\ncurrent" | peco)
  esac

  if [ "${selection}" = "" ]
  then
    return 1
  else
    case ${selecttype} in
      dir)
        echo "cd ${pre}${selection}"
        cd ${pre}${selection}
        ;;
      aws)
        echo "export AWS_PROFILE=${pre}${selection}"
        export AWS_PROFILE=${pre}${selection}
        ;;
      *)
        exit 1
        ;;
    esac
  fi
}
