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
ZSHRC   := ${HOME}/.zshrc

MAS_LINE := 539883307
MAS_DIVVY := 413857545

BREWS := wget the_silver_searcher amazon-ecs-cli colordiff lua reattach-to-user-namespace tmux heroku zstd graphviz peco knqyf263/pet/pet terminal-notifier ansible mas jq ttygif neovim git-lfs trash tig unar
CASKS := postman session-manager-plugin google-cloud-sdk drawio kindle alfred 1password karabiner-elements google-japanese-ime docker appcleaner mysqlworkbench firefox google-chrome-beta slack tunnelblick microsoft-edge visual-studio-code
MAS   := $(MAS_LINE) $(MAS_DIVVY)
YUMS  := wget the_silver_searcher
GO    := github.com/Code-Hex/Neo-cowsay/cmd/cowsay github.com/Code-Hex/Neo-cowsay/cmd/cowthink github.com/sugilog/instant-go github.com/motemen/ghq github.com/jesseduffield/lazydocker github.com/Songmu/make2help/cmd/make2help
# gopls need to set GO111MODULE


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

tools: localbin symlinks zplug package rbenv nodenv goenv pyenv neovim go awscli

tools-update: zplug-update package-update rbenv-update nodenv-update goenv-update pyenv-update neovim-update go-update awscli-update

localbin:
	mkdir -p ${LOCALBIN}

package:
ifeq ($(call DETECTOS),darwin)
	$(foreach formula,$(BREWS),brew install $(formula);)
	brew tap homebrew/cask
	$(foreach formula,$(CASKS),brew cask install $(formula);)
	$(foreach id,$(MAS),mas install $(id);)
	brew tap aws/tap
	brew install aws-sam-cli
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

# https://support.1password.com/could-not-connect/
chrome-beta:
ifeq ($(call DETECTOS),darwin)
	mkdir -p  ~/Library/Application\ Support/Google/Chrome
	open /Applications/Google\ Chrome\ Beta.app
	mkdir -p ~/Library/Application\ Support/Google/Chrome\ Beta/NativeMessagingHosts
	cp ~/Library/Application\ Support/Google/Chrome/NativeMessagingHosts/2bua8c4s2c.com.agilebits.1password.json ~/Library/Application\ Support/Google/Chrome\ Beta/NativeMessagingHosts/2bua8c4s2c.com.agilebits.1password.json
endif

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
	ln -sf ${HOME}/workspace/github.com/sugilog/dotfiles/zsh/zshrc ${HOME}/.zshrc
	ln -sf ${HOME}/workspace/github.com/sugilog/dotfiles/.irbrc ${HOME}/
	ln -sf ${HOME}/workspace/github.com/sugilog/dotfiles/.tmux.conf ${HOME}/
	ln -sf ${HOME}/workspace/github.com/sugilog/dotfiles/.tmuxinator ${HOME}/
	ln -sf ${HOME}/workspace/github.com/sugilog/dotfiles/.gitconfig ${HOME}/
	ln -sf $(HOME)/workspace/github.com/sugilog/dotfiles/tig/tigrc ${HOME}/.tigrc
	mkdir -p ${HOME}/.config
	ln -sf ${HOME}/workspace/github.com/sugilog/dotfiles/nvim ${HOME}/.config/
	ln -sf ${HOME}/workspace/github.com/sugilog/dotfiles/peco ${HOME}/.config/
	ln -sf ${HOME}/workspace/github.com/sugilog/dotfiles/pet ${HOME}/.config/
	ln -sf ${HOME}/workspace/github.com/sugilog/dotfiles/karabiner ${HOME}/.config/
	ln -sf ${HOME}/workspace/github.com/sugilog/dotfiles/zsh/zshrc ${HOME}/.zshrc
	ln -sf ${HOME}/workspace/github.com/sugilog/dotfiles/bash/profile ${HOME}/.bash_profile

go:
	$(foreach go,$(GO),go get -u $(go);)
	# Do not use the -u flag, as it will update your dependencies to incompatible versions.
	GO111MODULE=on go get golang.org/x/tools/gopls@latest

go-update: go

awscli:
ifeq ($(call DETECTOS),darwin)
	curl "https://awscli.amazonaws.com/AWSCLIV2.pkg" -o "/tmp/awscliv2.pkg"
	sudo installer -pkg /tmp/awscliv2.pkg -target /
	ln -sf /usr/local/aws-cli/aws /usr/local/bin/aws
	ln -sf /usr/local/aws-cli/aws_completer /usr/local/bin/aws_completer
else
	curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "/tmp/awscliv2.zip"
	unzip /tmp/awscliv2.zip -d /tmp
	sudo /tmp/aws/install --bin-dir /usr/local/bin --update
	ln -sf /usr/local/bin/aws2 /usr/local/bin/aws
endif

awscli-update: awscli

zplug:
	git clone https://github.com/zplug/zplug ${HOME}/.config/zplug

zplug-update:
	cd ${HOME}/.config/zplug && git pull

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

# temporary
rust:
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
	rustup component add rustfmt
