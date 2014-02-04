ReadMe
============================================================

About
------------------------------------------------------------
This repository manage the sugilog's individual settings.

HowToUse (repository)
------------------------------------------------------------
### Init
- clone this repository.
- pull and update submodules
```
git submodule init
git submodule update
```

### Update (sometimes)
- better to update submodules.
```
git submodule foreach 'git pull origin master'
git submodule update
```

HowToUse (settings)
------------------------------------------------------------
### add synbolic links
```
ln -s $HOME/dotfiles/.gvimrc         $HOME/
ln -s $HOME/dotfiles/.irbrc          $HOME/
ln -s $HOME/dotfiles/.muttatorrc     $HOME/
ln -s $HOME/dotfiles/.screenrc       $HOME/
ln -s $HOME/dotfiles/.tmux.conf      $HOME/
ln -s $HOME/dotfiles/.tmuxinator     $HOME/
ln -s $HOME/dotfiles/.vimperatorrc   $HOME/
ln -s $HOME/dotfiles/.vimrc          $HOME/
```

### copy secure-data-contain-able file
```
cp $HOME/dotfiles/.gitconfig $HOME/
```


...
