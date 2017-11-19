#!/data/data/com.termux/files/usr/bin/bash -e
# Copyright 2017 by SDRausty. All rights reserved.
# Website for this project at https://sdrausty.github.io/TermuxArch
# See https://sdrausty.github.io/TermuxArch/CONTRIBUTORS Thank You 
################################################################################

addbash_profile ()
{
	cat > root/.bash_profile <<- EOM
	PATH=\$HOME/bin:\$PATH
	. /root/.bashrc
	EOM
	grep export $HOME/.bash_profile >>  root/.bash_profile 
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
	alias e='exit'
	alias g='ga; gcm; gp'
	alias gca='git commit -a'
	alias gcam='git commit -am'
	#alias gp='git push https://username:password@github.com/username/repository.git master'
	alias h='history >> \$HOME/.historyfile'
	alias j='jobs'
	alias l='ls -al'
	alias ls='ls --color=always'
	alias p='pwd'
	alias q='exit'
	alias rf='rm -rf'
	alias v='vim'
	cat /etc/motd
	EOM
}

addga ()
{
	cat > root/bin/ga  <<- EOM
	#!/bin/bash -e
	git add .
	EOM
	chmod 700 root/bin/ga 
}

addgcl ()
{
	cat > root/bin/gcl  <<- EOM
	#!/bin/bash -e
	git clone \$1
	EOM
	chmod 700 root/bin/gcl 
}

addgcm ()
{
	cat > root/bin/gcm  <<- EOM
	#!/bin/bash -e
	git commit
	EOM
	chmod 700 root/bin/gcm 
}

addgpl ()
{
	cat > root/bin/gpl  <<- EOM
	#!/bin/bash -e
	git pull
	EOM
	chmod 700 root/bin/gpl 
}

addgp ()
{
	cat > root/bin/gp  <<- EOM
	#!/bin/bash -e
	git push
	#git push https://username:password@github.com/username/repository.git master
	EOM
	chmod 700 root/bin/gp 
}

addresolv.conf ()
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
	Welcome to Arch Linux in Termux!  Enjoy!

	Chat:    https://gitter.im/termux/termux/
	Help:    info <package> and  man <package> 
	Portal:  https://wiki.termux.com/wiki/Community

	Install a package: pacman -S <package>
	More  information: pacman -D|F|Q|R|S|T|U --help
	Search   packages: pacman -Ss <query>
	Upgrade  packages: pacman -Syu
	EOM
	chmod 700 root/bin/gp 
}

finishsetup ()
{
	cat > root/bin/finishsetup.sh  <<- EOM
	#!/bin/bash -e
	printf "\n\033[32;1m"
	while true; do
	read -p "Would you like to use \`nano\` or \`vi\` to edit your Arch Linux configuration files? (n|v)?"  nv
	if [[ \$nv = [Nn]* ]];then
		ed=nano
		break
	elif [[ \$nv = [Vv]* ]];then
		ed=vi
		break
	else
		printf "\nYou answered \033[36;1m\$nv\033[32;1m.\n"
		printf "\nAnswer nano or vi (n|v).\n\n"
	fi
	done	
	while true; do
	read -p "Would you like to run \`locale-gen\` to generate the en_US.UTF-8 locale or would like to edit /etc/locale.gen to specify your preferred locale before running \`locale-gen\`? See https://wiki.archlinux.org/index.php/Locale for more information.  1)	Answer yes (y) to run \`locale-gen\` to generate the en_US.UTF-8 locale (Yy).  2)	Answer edit (e) to edit /etc/locale.gen to specify your preferred locale before running \`locale-gen\`." ye
	if [[ \$ye = [Yy]* ]];then
		locale-gen
		break
	elif [[ \$ye = [Ee]* ]];then
		\$ed /etc/locale.gen
		locale-gen
		break
	else
		printf "\nYou answered \033[36;1m\$ye\033[32;1m.\n"
		printf "\nAnswer yes or edit (Yy|Ee).\n\n"
	fi
	done
	\$ed /etc/pacman.d/mirrorlist
	pacman -Syu --noconfirm ||:
	printf "\nUse \033[36;1mexit (e|q)\033[32;1m to conclude this installation.\033[0m\n\n"
	rm \$HOME/bin/finishsetup.sh 2>/dev/null ||:
	EOM
	chmod 700 root/bin/finishsetup.sh 
}

locale.gen ()
{
	if [ -f "etc/locale.gen" ]; then
		sed -i '/\#en_US.UTF-8 UTF-8/{s/#//g;s/@/-at-/g;}' etc/locale.gen 
	else
		cat >  etc/locale.gen <<- EOM
		en_US.UTF-8 UTF-8 
		EOM
	fi
}

startbin ()
{
	cat > $bin <<- EOM
	#!/data/data/com.termux/files/usr/bin/bash -e
	unset LD_PRELOAD
	exec proot --link2symlink -0 -r $HOME/arch/ -b /dev/ -b /sys/ -b /proc/ -b /storage/ -b $HOME -w $HOME /bin/env -i HOME=/root TERM="$TERM" PS1='[termux@arch \W]\$ ' LANG=$LANG PATH=/bin:/usr/bin:/sbin:/usr/sbin /bin/bash --login
	EOM
	chmod 700 $bin
}

