#!/bin/sh

# Backup
BACKUP_DIR_NAME_CONFIG="$HOME/.config/nvim.bak"
BACKUP_DIR_NAME_CONFIG_NUM=0
BACKUP_DIR_NAME_CACHE="$HOME/.local/share/nvim.bak"
BACKUP_DIR_NAME_CACHE_NUM=0

while true
do
    DIR=""
    if [ $BACKUP_DIR_NAME_CONFIG_NUM -eq 0 ]
    then
        DIR="$BACKUP_DIR_NAME_CONFIG"
    else
        DIR="$BACKUP_DIR_NAME_CONFIG$BACKUP_DIR_NAME_CONFIG_NUM"
    fi

    if [ -d "$DIR" ];
    then
        BACKUP_DIR_NAME_CONFIG_NUM=$(($BACKUP_DIR_NAME_CONFIG_NUM + 1))
    else
        break
    fi
done
if [ $BACKUP_DIR_NAME_CONFIG_NUM -eq 0 ]
then
    BACKUP_DIR_NAME_CONFIG="$BACKUP_DIR_NAME_CONFIG"
else
    BACKUP_DIR_NAME_CONFIG="$BACKUP_DIR_NAME_CONFIG$BACKUP_DIR_NAME_CONFIG_NUM"
fi

while true
do
    DIR=""
    if [ $BACKUP_DIR_NAME_CACHE_NUM -eq 0 ]
    then
        DIR="$BACKUP_DIR_NAME_CACHE"
    else
        DIR="$BACKUP_DIR_NAME_CACHE$BACKUP_DIR_NAME_CACHE_NUM"
    fi

    if [ -d "$DIR" ];
    then
        BACKUP_DIR_NAME_CACHE_NUM=$(($BACKUP_DIR_NAME_CACHE_NUM + 1))
    else
        break
    fi
done
if [ $BACKUP_DIR_NAME_CACHE_NUM -eq 0 ]
then
    BACKUP_DIR_NAME_CACHE="$BACKUP_DIR_NAME_CACHE"
else
    BACKUP_DIR_NAME_CACHE="$BACKUP_DIR_NAME_CACHE$BACKUP_DIR_NAME_CACHE_NUM"
fi

mv ~/.config/nvim $BACKUP_DIR_NAME_CONFIG
mv ~/.local/share/nvim $BACKUP_DIR_NAME_CACHE


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

echo ""
echo ""
echo "----------"
echo "Installed silvnvim!"
echo "Your previous config has been backed up in the following places:"
echo "	- $BACKUP_DIR_NAME_CONFIG"
echo "	- $BACKUP_DIR_NAME_CACHE"
