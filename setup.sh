#!/bin/sh
ln -fs ~/.vim/.vimrc ~/.vimrc
mkdir -p bundle
git clone https://github.com/gmarik/vundle.git bundle/vundle
vim +PluginInstall +qall
