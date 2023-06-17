#!/bin/sh

# Backup
mv ~/.config/nvim ~/.config/nvim.bak
mv ~/.local/share/nvim ~/.local/share/nvim.bak

# Clone core
git clone https://github.com/silvnvim/core ~/.config/nvim
rm -rf ~/.config/nvim/.git

if [ $# -eq 0 ]
then
    git clone --recursive https://github.com/silvnvim/starter_config ~/.config/nvim/lua/config
else
    if [ "$1" = "starter" ]
    then
        git clone --recursive https://github.com/silvnvim/starter_config ~/.config/nvim/lua/config
    elif [ "$1" = "none" ]
    then
        :
    else
    	git clone --recursive "$1" ~/.config/nvim/lua/config
    fi
fi
