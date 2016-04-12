if [ ! -d $HOME/.oh-my-zsh ]; then
  wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O - | sh
  ln -s $HOME/dotfiles/oh-my-zsh/custom/*.zsh $HOME/.oh-my-zsh/custom
  ln -s $HOME/dotfiles/oh-my-zsh/custom/*.zsh-theme $HOME/.oh-my-zsh/custom
  ln -s $HOME/dotfiles/oh-my-zsh/custom/plugins/* $HOME/.oh-my-zsh/custom/plugins
  sed -i -e "1i export DISABLE_UPDATE_PROMPT=true" $HOME/.zshrc
  sed -i -e 's/ZSH_THEME="[^"]*"/ZSH_THEME="my_theme"/g' $HOME/.zshrc
  sed -i -e "s/^plugins=(\(.*\))$/plugins=(\1 tmuxinator zshmarks golang)/g" $HOME/.zshrc
fi
