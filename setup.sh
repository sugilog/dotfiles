# add synbolic links
ln -s $HOME/dotfiles/.gvimrc         $HOME/
ln -s $HOME/dotfiles/.irbrc          $HOME/
ln -s $HOME/dotfiles/.muttatorrc     $HOME/
ln -s $HOME/dotfiles/.screenrc       $HOME/
ln -s $HOME/dotfiles/.tmux.conf      $HOME/
ln -s $HOME/dotfiles/.tmuxinator     $HOME/
ln -s $HOME/dotfiles/.vimperatorrc   $HOME/
ln -s $HOME/dotfiles/.vimrc          $HOME/

# copy gitconfig
cp $HOME/dotfiles/.gitconfig $HOME/

# with oh-my-zsh

if [ ! -d $HOME/.oh-my-zsh ]; then
  wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O - | sh
  ln -s $HOME/dotfiles/oh-my-zsh/custom/*.zsh $HOME/.oh-my-zsh/custom
  ln -s $HOME/dotfiles/oh-my-zsh/custom/plugins/* $HOME/.oh-my-zsh/custom/plugins
  sed -i -e "1i export DISABLE_UPDATE_PROMPT=true" $HOME/.zshrc
  sed -i -e 's/ZSH_THEME="[^"]*"/ZSH_THEME="my_theme"/g' $HOME/.zshrc
  sed -i -e "s/^plugins=(\(.*\))$/plugins=(\1 tmuxinator zshmarks golang)/g" $HOME/.zshrc
fi
