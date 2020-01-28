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

BREWS := wget the_silver_searcher amazon-ecs-cli colordiff lua reattach-to-user-namespace tmux heroku zstd graphviz peco knqyf263/pet/pet irssi terminal-notifier ansible mas jq ttygif neovim git-lfs trash tig unar
CASKS := postman google-cloud-sdk drawio jadengeller-helium kindle alfred 1password karabiner-elements google-japanese-ime docker appcleaner mysqlworkbench firefox homebrew/cask-versions/google-chrome-beta figma
MAS   := $(MAS_LINE) $(MAS_DIVVY) $(MAS_MINICAL) $(MAS_UNARCHIVER)
YUMS  := wget the_silver_searcher
GO    := github.com/lucagrulla/cw github.com/Code-Hex/Neo-cowsay/cmd/cowsay github.com/Code-Hex/Neo-cowsay/cmd/cowthink golang.org/x/tools/cmd/gopls github.com/sugilog/instant-go github.com/motemen/ghq github.com/ericchiang/pup


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

tools: localbin package ohmyzsh rbenv nodenv goenv pyenv neovim symlinks go awscli

tools-update: package-update rbenv-update nodenv-update goenv-update pyenv-update neovim-update go-update awscli-update

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
	# $(foreach formula,$(CASKS),brew cask upgrade $(formula);)echo continue
else
	@echo FIXME
endif

ohmyzsh:
ifeq ($(call DIREXISTS,${OHMYZSH}),0)
	wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O - | sh
endif
	sed -i -e "1i export DISABLE_UPDATE_PROMPT=true" ${ZSHRC}
	sed -i -e 's/ZSH_THEME="[^"]*"/ZSH_THEME="my_theme"/g' ${ZSHRC}
	sed -i -e "s/^plugins=(\(.*\))$/plugins=(\1 tmuxinator golang)/g" ${ZSHRC}

rbenv:
ifeq ($(call BINEXISTS,rbenv),0)
ifeq ($(call DETECTOS),linux-)
	sudo yum install -y gcc openssl-devel readline-devel zlib-devel
endif
	git clone https://github.com/rbenv/rbenv.git ${HOME}/.rbenv
	git clone https://github.com/rbenv/ruby-build.git ${HOME}/.rbenv/plugins/ruby-build
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
	CFLAGS="-I$$(xcrun --show-sdk-path)/usr/include" pyenv install --skip-existing 3.6.8
else
	pyenv install --skip-existing 3.6.8
endif
	pyenv virtualenv -f 3.6.8 neovim3
	pyenv global neovim3

pyenv-update:
ifeq ($(call DIREXISTS,${HOME}/.pyenv),1)
	cd ${HOME}/.pyenv && git pull
	cd ${HOME}/.pyenv/plugins/pyenv-virtualenv && git pull
endif

neovim: python-install
	pip3 install --upgrade pynvim
ifeq ($(call DETECTOS),linux-)
	-sudo yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
	-sudo yum --enablerepo=epel -y install fuse-sshfs
	curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
	chmod u+x nvim.appimage
	sudo mv nvim.appimage /usr/local/bin/nvim
endif

neovim-update: neovim

symlinks:
	ln -sf ${HOME}/dotfiles/.irbrc      ${HOME}/
	ln -sf ${HOME}/dotfiles/.tmux.conf  ${HOME}/
	ln -sf ${HOME}/dotfiles/.tmuxinator ${HOME}/
	ln -sf ${HOME}/dotfiles/.gitconfig  ${HOME}/
	ln -sf $(HOME)/dotfiles/tig/tigrc ${HOME}/.tigrc
	mkdir -p ${HOME}/.config
	ln -sf ${HOME}/dotfiles/nvim ${HOME}/.config/
	ln -sf ${HOME}/dotfiles/peco ${HOME}/.config/
	ln -sf ${HOME}/dotfiles/pet ${HOME}/.config/
	ln -sf ${HOME}/dotfiles/karabiner ${HOME}/.config/
ifeq ($(call DIREXISTS,${OHMYZSH}),1)
	ln -sf ${HOME}/dotfiles/oh-my-zsh/custom/*.zsh       ${OHMYZSH}/custom
	ln -sf ${HOME}/dotfiles/oh-my-zsh/custom/*.zsh-theme ${OHMYZSH}/custom
	ln -sf ${HOME}/dotfiles/oh-my-zsh/custom/plugins/*   ${OHMYZSH}/plugins
else
	ln -sf ${HOME}/dotfiles/.zshrc ${HOME}/
endif

go:
	$(foreach go,$(GO),go get -u $(go);)

go-update: go

awscli:
ifeq ($(call DETECTOS),darwin)
	curl "https://d1vvhvl2y92vvt.cloudfront.net/awscli-exe-macos.zip" -o "/tmp/awscliv2.zip"
else
	curl "https://d1vvhvl2y92vvt.cloudfront.net/awscli-exe-linux-x86_64.zip" -o "/tmp/awscliv2.zip"
endif
	unzip /tmp/awscliv2.zip -d /tmp
	sudo /tmp/aws/install --bin-dir /usr/local/bin --update
	ln -sf /usr/local/bin/aws2 /usr/local/bin/aws

awscli-update: awscli

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
