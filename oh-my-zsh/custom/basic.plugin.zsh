function chpwd() {
  local _markname="last"
  local _directory=`showmarks ${_markname:?}`

  if [[ " " != ${_directory:?} ]]; then
    deletemark ${_markname:?}
  fi

  bookmark ${_markname:?} > /dev/null
}
