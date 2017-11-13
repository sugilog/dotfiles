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

BREWS := wget the_silver_searcher awscli colordiff lua reattach-to-user-namespace tmux
CASKS := macvim rstudio
YUMS  := wget the_silver_searcher

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

tools: localbin package ohmyzsh awsenv rbenv nodenv goenv vimenv symlinks

tools-update: package-update awsenv-update rbenv-update nodenv-update goenv-update vimenv-update

localbin:
	mkdir -p ${LOCALBIN}

list = hoge fuga piyo

hoge:
	@$(foreach t,$(list),echo ${t};)

package:
ifeq ($(call DETECTOS),darwin)
	$(foreach formula,$(BREWS),brew install $(formula);)
	brew tap caskroom/cask
	$(foreach formula,$(CASKS),brew cask install $(formula);)
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

vimenv:
ifeq ($(call BINEXISTS,vimenv),0)
	git clone https://github.com/raa0121/vimenv.git ${HOME}/.vimenv
	git clone https://github.com/yasu-n/vim-build.git ${HOME}/.vimenv/plugins/vim-build
endif

vimenv-update:
ifeq ($(call DIREXISTS,${HOME}/.vimenv),1)
	cd ${HOME}/.vimenv && git pull
	cd ${HOME}/.vimenv/plugins/vim-build && git pull
endif

symlinks:
	ln -sf ${HOME}/dotfiles/.gvimrc     ${HOME}/
	ln -sf ${HOME}/dotfiles/.irbrc      ${HOME}/
	ln -sf ${HOME}/dotfiles/.tmux.conf  ${HOME}/
	ln -sf ${HOME}/dotfiles/.tmuxinator ${HOME}/
	ln -sf ${HOME}/dotfiles/.vimrc      ${HOME}/
	ln -sf ${HOME}/dotfiles/.gitconfig  ${HOME}/
ifeq ($(call DETECTOS),darwin)
	ln -sf ${HOME}/dotfiles/.brewfile   ${HOME}/
endif
ifeq ($(call DIREXISTS,${OHMYZSH}),1)
	ln -sf ${HOME}/dotfiles/oh-my-zsh/custom/*.zsh       ${OHMYZSH}/custom
	ln -sf ${HOME}/dotfiles/oh-my-zsh/custom/*.zsh-theme ${OHMYZSH}/custom
	ln -sf ${HOME}/dotfiles/oh-my-zsh/custom/plugins/*   ${OHMYZSH}/plugins
else
	ln -sf ${HOME}/dotfiles/.zshrc ${HOME}/
endif

.DEFAULT_GOAL = help

.PHONY: help init update tools localbin package ohmyzsh awsenv rbenv nodenv goenv vimenv symlinks awsenv-update rbenv-update nodenv-update goenv-update vimenv-update

