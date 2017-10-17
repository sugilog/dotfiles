mkdir -p $HOME/bin

case ${OSTYPE:0:6} in
  "linux-" )
    sudo yum install the_silver_searcher
    ;;
  "darwin" )
    brew install the_silver_searcher
    ;;
  * )
    ;;
esac

