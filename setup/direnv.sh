_url=""

function _detect_url() {
  _version="v2.10.0"

  case ${OSTYPE:0:6} in
    "linux-" )
      _os="linux-amd64"
      ;;
    "darwin" )
      _os="darwin-amd64"
      ;;
    * )
      return 1;
      ;;
  esac

  _url="https://github.com/direnv/direnv/releases/download/${_version}/direnv.${_os}"
}

which direnv

if [ $? -ne 0 ]; then
  _detect_url

  if [ ${_url} != "" ]; then
    mkdir -p $HOME/bin
    wget ${_url} -O $HOME/bin/direnv
    chmod +x $HOME/bin/direnv
  else
    echo "Failed to detect url"
    exit 1
  fi
fi
