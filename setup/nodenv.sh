git clone https://github.com/nodenv/nodenv.git $HOME/.nodenv
git clone https://github.com/nodenv/node-build.git $HOME/.nodenv/plugins/node-build
cd $HOME/.nodenv && src/configure && make -C src
