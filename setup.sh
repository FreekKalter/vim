#!/bin/bash

# Install neccesary programs
NEEDED_PROGS=( git vim )
TO_INSTALL=""

# [@] will get all elements, crazy bash
for prog in "${NEEDED_PROGS[@]}"; do
    if [[ -z $(command -v $prog) ]]; then
        TO_INSTALL="$TO_INSTALL $prog"
    fi
done

if [[ -n $TO_INSTALL ]]; then
    echo "[-] going to install $TO_INSTALL"
    sudo apt-get install -y $TO_INSTALL
    echo "[+] installed necessary programs"
fi

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
