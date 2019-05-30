define DIREXISTS
$(shell test -s $1 && echo 1 || echo 0)
endef

define BINEXISTS
$(lastword $(shell which $1 2>/dev/null; test $${?} -eq 0 && echo 1 || echo 0))
endef

define DETECTOS
$(shell echo $${OSTYPE:0:6})
endef

LOCALBIN := ${HOME}/bin
OHMYZSH := ${HOME}/.oh-my-zsh
ZSHRC   := ${HOME}/.zshrc

MAS_LINE := 539883307
MAS_DIVVY := 413857545
MAS_MINICAL := 1088779979
MAX_UNARCHIVER := 425424353

BREWS := wget the_silver_searcher awscli amazon-ecs-cli colordiff lua reattach-to-user-namespace tmux heroku zstd graphviz peco knqyf263/pet/pet irssi terminal-notifier ansible mas jq ttygif neovim
CASKS := rstudio postman google-cloud-sdk drawio jadengeller-helium kindle alfred 1password karabiner-elements google-japanese-ime docker appcleaner mysqlworkbench firefox oni
MAS   := $(MAS_LINE) $(MAS_DIVVY) $(MAS_MINICAL) $(MAS_UNARCHIVER)
YUMS  := wget the_silver_searcher
GO    := lycoris0731/salias lucagrulla/cw Code-Hex/Neo-cowsay/cmd/cowsay Code-Hex/Neo-cowsay/cmd/cowthink

.DEFAULT_GOAL = help

help:
	@echo "init     : init submodules"
	@echo "update   : update submodules"
	@echo "symlinks : add symlinks"
	@echo "tools    : install tools and add symlinks"
	@echo "tools-update : update tools except brew cask"

init:
	git submodule init
	git submodule update

update:
	git submodule update --init --remote --recursive

tools: localbin package ohmyzsh awsenv rbenv nodenv goenv pyenv neovim symlinks go

tools-update: package-update awsenv-update rbenv-update nodenv-update goenv-update pyenv-update neovim-update go-update

localbin:
	mkdir -p ${LOCALBIN}

package:
ifeq ($(call DETECTOS),darwin)
	$(foreach formula,$(BREWS),brew install $(formula);)
	brew tap caskroom/cask
	$(foreach formula,$(CASKS),brew cask install $(formula);)
	$(foreach id,$(MAS),mas install $(id);)
else
	sudo yum install $(YUMS)
endif

package-update:
ifeq ($(call DETECTOS),darwin)
	$(foreach formula,$(BREWS),brew upgrade $(formula);)echo continue
else
	@echo FIXME
endif

ohmyzsh:
ifeq ($(call DIREXISTS,${OHMYZSH}),0)
	wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O - | sh
endif
	sed -i -e "1i export DISABLE_UPDATE_PROMPT=true" ${ZSHRC}
	sed -i -e 's/ZSH_THEME="[^"]*"/ZSH_THEME="my_theme"/g' ${ZSHRC}
	sed -i -e "s/^plugins=(\(.*\))$/plugins=(\1 tmuxinator zshmarks golang)/g" ${ZSHRC}

awsenv:
	wget https://raw.githubusercontent.com/bdclark/awsenv/master/awsenv -O ${LOCALBIN}/awsenv
	chmod +x ${LOCALBIN}/awsenv
ifeq ($(call BINEXISTS,awsenv),0)
	echo 'setaws() { [[ $$# -gt 0 ]] && eval "$$($$HOME/bin/awsenv $$@)"; }' >> ${ZSHRC}
endif

awsenv-update: awsenv

rbenv:
ifeq ($(call BINEXISTS,rbenv),0)
ifeq ($(call DETECTOS),linux-)
	sudo yum install -y gcc openssl-devel readline-devel zlib-devel
endif
	git clone https://github.com/sstephenson/rbenv.git ${HOME}/.rbenv
	git clone https://github.com/sstephenson/ruby-build.git ${HOME}/.rbenv/plugins/ruby-build
endif

rbenv-update:
ifeq ($(call DIREXISTS,${HOME}/.rbenv),1)
	cd ${HOME}/.rbenv && git pull
	cd ${HOME}/.rbenv/plugins/ruby-build && git pull
endif

nodenv:
ifeq ($(call BINEXISTS,nodenv),0)
	git clone https://github.com/nodenv/nodenv.git ${HOME}/.nodenv
	git clone https://github.com/nodenv/node-build.git ${HOME}/.nodenv/plugins/node-build
	cd ${HOME}/.nodenv && src/configure && make -C src
endif

nodenv-update:
ifeq ($(call DIREXISTS,${HOME}/.nodenv),1)
	cd ${HOME}/.nodenv && git pull
	cd ${HOME}/.nodenv/plugins/node-build && git pull
endif

goenv:
ifeq ($(call BINEXISTS,goenv),0)
	git clone https://github.com/syndbg/goenv.git ${HOME}/.goenv
endif

goenv-update:
ifeq ($(call DIREXISTS,${HOME}/.goenv),1)
	cd ${HOME}/.goenv && git pull
endif

pyenv:
ifeq ($(call BINEXISTS,pyenv),0)
	git clone https://github.com/pyenv/pyenv.git ${HOME}/.pyenv
	git clone https://github.com/pyenv/pyenv-virtualenv.git ${HOME}/.pyenv/plugins/pyenv-virtualenv
endif

python-install:
ifeq ($(call DETECTOS),darwin)
	CFLAGS="-I$$(xcrun --show-sdk-path)/usr/include" pyenv install 2.7.16
	CFLAGS="-I$$(xcrun --show-sdk-path)/usr/include" pyenv install 3.6.8
else
	pyenv install 2.7.16
	pyenv install 3.6.8
endif
	pyenv virtualenv 2.7.16 neovim2
	pyenv virtualenv 3.6.8 neovim3
	pyenv global neovim2 neovim3

pyenv-update:
ifeq ($(call DIREXISTS,${HOME}/.pyenv),1)
	cd ${HOME}/.pyenv && git pull
	cd ${HOME}/.pyenv/plugins/pyenv-virtualenv && git pull
endif

neovim: python-install
	pip install --upgrade pynvim
	pip3 install --upgrade pynvim
ifeq ($(call DETECTOS),linux-)
	sudo yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
	sudo yum install --enablerepo=epel -y neovim
endif

neovim-update: neovim

symlinks:
	ln -sf ${HOME}/dotfiles/.gvimrc     ${HOME}/
	ln -sf ${HOME}/dotfiles/.irbrc      ${HOME}/
	ln -sf ${HOME}/dotfiles/.tmux.conf  ${HOME}/
	ln -sf ${HOME}/dotfiles/.tmuxinator ${HOME}/
	mkdir -p ${HOME}/.config/nvim
	ln -sf ${HOME}/dotfiles/.vimrc      ${HOME}/.config/nvim/init.vim
	ln -sf ${HOME}/dotfiles/.gitconfig  ${HOME}/
ifeq ($(call DIREXISTS,${OHMYZSH}),1)
	ln -sf ${HOME}/dotfiles/oh-my-zsh/custom/*.zsh       ${OHMYZSH}/custom
	ln -sf ${HOME}/dotfiles/oh-my-zsh/custom/*.zsh-theme ${OHMYZSH}/custom
	ln -sf ${HOME}/dotfiles/oh-my-zsh/custom/plugins/*   ${OHMYZSH}/plugins
else
	ln -sf ${HOME}/dotfiles/.zshrc ${HOME}/
endif
	mkdir -p ${HOME}/.config
	ln -sf ${HOME}/dotfiles/pet ${HOME}/.config/

go:
	$(foreach go,$(GO),go get -u github.com/$(go);)

go-update: go

behavior:
ifeq ($(call DETECTOS),darwin)
	defaults write NSGlobalDomain InitialKeyRepeat -int 12
	defaults write NSGlobalDomain KeyRepeat -int 1
	defaults -currentHost write com.apple.screensaver idleTime 120
	defaults -currentHost write com.apple.screensaver moduleDict -dict-add moduleName "Computer Name"
	defaults -currentHost write com.apple.screensaver moduleDict -dict-add path "`ls -d /System/Library/Frameworks/ScreenSaver.framework/Resources/Computer*`"
	defaults read NSGlobalDomain | grep Key
	defaults -currentHost read com.apple.screensaver
endif
