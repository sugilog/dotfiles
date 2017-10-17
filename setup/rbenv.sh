case ${OSTYPE:0:6} in
  "linux-" )
    sudo yum install -y gcc openssl-devel readline-devel zlib-devel
    ;;
  * )
    ;;
esac

git clone https://github.com/sstephenson/rbenv.git $HOME/.rbenv
git clone https://github.com/sstephenson/ruby-build.git $HOME/.rbenv/plugins/ruby-build

