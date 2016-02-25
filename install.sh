#!/bin/sh


mv ~/.vimrc ~/.vimrc-backup
mv ~/.vim ~/.vim-backup

cp -r ./ ~/.vim/

YOU_COMPLETE_INSTALLED=`dpkg-query -f='${db:Status-Status}' -W vim-youcompleteme`

if [ "$YOU_COMPLETE_INSTALLED" != "installed" ]
then
	echo "Installing vim-youcompleteme"
	sudo apt-get install vim-youcompleteme
fi

vam install youcompleteme

vim -c PlugInstall
