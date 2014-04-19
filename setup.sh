#!/bin/sh
ln -fs ~/.vim/.vimrc ~/.vimrc
echo "[+] link created"
mkdir -p bundle
echo "[+] bundle dir created"
echo "[-] getting vundle"
git clone https://github.com/gmarik/vundle.git bundle/vundle
echo "[+] vundle cloned"
echo "[-] installing plugins"
vim +PluginInstall +qall
echo "[-] plugins installed"
