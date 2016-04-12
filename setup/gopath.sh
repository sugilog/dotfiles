if [ `cat $HOME/.zshrc | grep GOPATH | wc -l` -eq 0 ]; then
  echo "GOPATH=$HOME/.go" >> $HOME/.zshrc
fi
