which awsenv

if [ $? -ne 0 ]; then
  mkdir -p $HOME/bin
  wget https://raw.githubusercontent.com/bdclark/awsenv/master/awsenv -O $HOME/bin/awsenv
  chmod +x $HOME/bin/awsenv
  echo 'setaws() { [[ $# -gt 0 ]] && eval "$($HOME/bin/awsenv $@)"; }' >> $HOME/.zshrc
fi
