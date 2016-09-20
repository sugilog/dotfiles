function chpwd() {
  local _markname="last"
  local _directory=`showmarks ${_markname:?}`

  while [[ " " != ${_directory:?} ]]; do
    deletemark ${_markname:?}
    _directory=`showmarks ${_markname:?}`
  done

  bookmark ${_markname:?} > /dev/null
}
