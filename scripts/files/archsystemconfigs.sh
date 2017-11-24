#!/data/data/com.termux/files/usr/bin/bash -e
# Copyright 2017 by SDRausty. All rights reserved.
# Website for this project at https://sdrausty.github.io/TermuxArch
# See https://sdrausty.github.io/TermuxArch/CONTRIBUTORS Thank You 
################################################################################

addbash_profile ()
{
	cat > root/.bash_profile <<- EOM
	PATH=\$HOME/bin:\$PATH
	. \$HOME/.bashrc
	PS1="[\A\[\033[0;32m\] \W \[\033[0m\]]\\$ "
	EOM
	if [ ! -e $HOME/.bash_profile ] ; then
		:
	else
		grep proxy $HOME/.bash_profile |grep "export" >>  root/.bash_profile 2>/dev/null||:
	fi
}

addbashrc ()
{
	cat > root/.bashrc <<- EOM
	alias c='cd .. && pwd'
	alias ..="cd ../.. && pwd"
	alias ...="cd ../../.. && pwd"
	alias ....="cd ../../../.. && pwd"
	alias .....="cd ../../../../.. && pwd"
	alias d='du -hs'
	alias e='logout'
	alias g='ga; gcm; gp'
	alias gca='git commit -a'
	alias gcam='git commit -am'
	#alias gp='git push https://username:password@github.com/username/repository.git master'
	alias h='history >> \$HOME/.historyfile'
	alias j='jobs'
	alias l='ls -alG'
	alias ls='ls --color=always'
	alias p='pwd'
	alias q='logout'
	alias rf='rm -rf'
	. /etc/motd
	EOM
	if [ ! -e $HOME/.bashrc ] ; then
		:
	else
		grep proxy $HOME/.bashrc |grep "export" >>  root/.bashrc 2>/dev/null||:
	fi
}

addprofile ()
{
	cat > root/.profile <<- EOM
	. \$HOME/.bash_profile
	EOM
	if [ ! -e $HOME/.profile ] ; then
		:
	else
		grep proxy $HOME/.profile |grep "export" >>  root/.profile 2>/dev/null||:
	fi
}

addga ()
{
	cat > root/bin/ga  <<- EOM
	#!/bin/bash -e
	if [ ! -e /usr/bin/git ] ; then
		pacman -Syu git --noconfirm
		git add .
	else
		git add .
	fi
	EOM
	chmod 700 root/bin/ga 
}

addgcl ()
{
	cat > root/bin/gcl  <<- EOM
	#!/bin/bash -e
	if [ ! -e /usr/bin/git ] ; then
		pacman -Syu git --noconfirm
		git clone \$@
	else
		git clone \$@
	fi
	EOM
	chmod 700 root/bin/gcl 
}

addgcm ()
{
	cat > root/bin/gcm  <<- EOM
	#!/bin/bash -e
	if [ ! -e /usr/bin/git ] ; then
		pacman -Syu git --noconfirm
		git commit
	else
		git commit
	fi
	EOM
	chmod 700 root/bin/gcm 
}

addgpl ()
{
	cat > root/bin/gpl  <<- EOM
	#!/bin/bash -e
	if [ ! -e /usr/bin/git ] ; then
		pacman -Syu git --noconfirm
		git pull
	else
		git pull
	fi
	EOM
	chmod 700 root/bin/gpl 
}

addgp ()
{
	cat > root/bin/gp  <<- EOM
	#!/bin/bash -e
	#git push https://username:password@github.com/username/repository.git master
	if [ ! -e /usr/bin/git ] ; then
		pacman -Syu git --noconfirm
		git push
	else
		git push
	fi
	EOM
	chmod 700 root/bin/gp 
}

addresolvconf ()
{
	rm etc/resolv* 2>/dev/null||:
	cat > etc/resolv.conf <<- EOM
	nameserver 8.8.8.8
	nameserver 8.8.4.4
	EOM
}

addmotd ()
{
	cat > etc/motd  <<- EOM
	printf "\033[1;34mWelcome to Arch Linux in Termux!  Enjoy!\033[0m\033[1;34m
	
	Chat:    \033[0m\033[mhttps://gitter.im/termux/termux/\033[0m\033[1;34m
	Help:    \033[0m\033[34minfo <query> \033[0m\033[mand \033[0m\033[34mman <query> \033[0m\033[1;34m
	Portal:  \033[0m\033[mhttps://wiki.termux.com/wiki/Community\033[0m\033[1;34m
	
	Install a package: \033[0m\033[34mpacman -S <package>\033[0m\033[1;34m
	More  information: \033[0m\033[34mpacman [-D|F|Q|R|S|T|U] --help\033[0m\033[1;34m
	Search   packages: \033[0m\033[34mpacman -Ss <query>\033[0m\033[1;34m
	Upgrade  packages: \033[0m\033[34mpacman -Syu \n\033[0m"
	EOM
	chmod 700 root/bin/gp 
}

makefinishsetup ()
{
	cat > root/bin/finishsetup.sh  <<- EOM
	#!/bin/bash -e
	EOM
	grep proxy $HOME/.bash_profile >>  root/bin/finishsetup.sh 2>/dev/null||:
	grep proxy $HOME/.bashrc >>  root/bin/finishsetup.sh 2>/dev/null||:
	grep proxy $HOME/.profile >>  root/bin/finishsetup.sh 2>/dev/null||:
	cat >> root/bin/finishsetup.sh  <<- EOM
	locale-gen
	pacman -Syu --noconfirm ||:
	printf '\033]2; 🕙 < 🕛 Your Arch Linux in Termux is installed and configured.  📲  \007'
	rm \$HOME/bin/finishsetup.sh 2>/dev/null ||:
	EOM
	chmod 700 root/bin/finishsetup.sh 
}

setlocalegen()
{
	if [ -e "etc/locale.gen" ]; then
		sed -i '/\#en_US.UTF-8 UTF-8/{s/#//g;s/@/-at-/g;}' etc/locale.gen 
	else
		cat >  etc/locale.gen <<- EOM
		en_US.UTF-8 UTF-8 
		EOM
	fi
}

makestartbin ()
{
	cat > $bin <<- EOM
	#!/data/data/com.termux/files/usr/bin/bash -e
	unset LD_PRELOAD
	exec proot --link2symlink -0 -r $HOME/arch/ -b /dev/ -b /sys/ -b /proc/ -b /storage/ -b $HOME -w $HOME /bin/env -i HOME=/root TERM="$TERM" PS1='[termux@arch \W]\$ ' LANG=$LANG PATH=/bin:/usr/bin:/sbin:/usr/sbin /bin/bash --login
	EOM
	chmod 700 $bin
}

makesetupbin ()
{
	cat > root/bin/setupbin.sh <<- EOM
	#!/data/data/com.termux/files/usr/bin/bash -e
	unset LD_PRELOAD
	exec proot --link2symlink -0 -r $HOME/arch/ -b /dev/ -b /sys/ -b /proc/ -b /storage/ -b $HOME -w $HOME /bin/env -i HOME=/root TERM="$TERM" PS1='[termux@arch \W]\$ ' LANG=$LANG PATH=/bin:/usr/bin:/sbin:/usr/sbin $HOME/arch/root/bin/finishsetup.sh
	EOM
	chmod 700 root/bin/setupbin.sh
}

addt ()
{
	cat > root/bin/t  <<- EOM
	#!/bin/bash -e
	if [ ! -e /usr/bin/tree ] ; then
		pacman -Syu tree --noconfirm
		tree \$@
	else
		tree \$@
	fi
	EOM
	chmod 700 root/bin/t 
}

addyt ()
{
	cat > root/bin/yt  <<- EOM
	#!/bin/bash -e
	if [ ! -e /usr/bin/youtube-dl ] ; then
		pacman -Syu python-pip --noconfirm
		pip install youtube-dl
		youtube-dl \$@
	else
		youtube-dl \$@
	fi
	EOM
	chmod 700 root/bin/yt 
}

addv ()
{
	cat > root/bin/v  <<- EOM
	#!/bin/bash -e
	if [ ! -e /usr/bin/vim ] ; then
		pacman -Syu vim --noconfirm
		vim \$@
	else
		vim \$@
	fi
	EOM
	chmod 700 root/bin/v 
}

