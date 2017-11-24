#!/data/data/com.termux/files/usr/bin/bash -e
# Copyright 2017 by SDRausty. All rights reserved.  🌎 🌍 🌏 🌐 🗺
# Website for this project at https://sdrausty.github.io/TermuxArch
# See https://sdrausty.github.io/TermuxArch/CONTRIBUTORS Thank You! 
# If you are encountering issues with the system-image.tar.gz file regarding download time, repository website connection and/or md5 checksum error, edit this script and change $mirror to your desired geographic location in knownconfigurations.sh.  Before editing this file, ensure termux-wake-lock is running during script operation and that you have a stable Internet connection. 
################################################################################

bin=startarch

depends ()
{
	printf '\033]2;  Thank you for using `setupTermuxArch.sh` 📲 \007'"\n 🕛 \033[36;1m< 🕛 \033[1;34mThis setup script will attempt to set Arch Linux up in your Termux environment.  When successfully completed, you will be enjoying the bash prompt in Arch Linux in Termux on your smartphone or tablet.  If you do not see 🕐 one o'clock below, check your Internet connection and run this script again.  "
if [ -e $PREFIX/bin/bsdtar ] && [ -e $PREFIX/bin/proot ] && [ -e $PREFIX/bin/wget ] ; then
	printf "Termux package requirements for Arch Linux: \033[36;1mOK  \n\n"
else
	printf "\n\n\033[36;1m"
	apt-get -qq update && apt-get -qq upgrade -y
	apt-get -qq install bsdtar proot wget --yes 
	printf "\n 🕧 < 🕛 \033[1;34mTermux package requirements for Arch Linux: \033[36;1mOK  \n\n"
fi
wget -q -N --show-progress https://raw.githubusercontent.com/sdrausty/TermuxArch/master/setupTermuxArch.tar.gz
wget -q -N --show-progress https://raw.githubusercontent.com/sdrausty/TermuxArch/master/setupTermuxArch.md5 
printf "\n"
if md5sum -c setupTermuxArch.md5 ; then
	printf "\n 🕐 \033[36;1m< 🕛 \033[1;34mInstallation script download: \033[36;1mOK  \n\n\033[36;1m"
	bsdtar -xf setupTermuxArch.tar.gz
	rmds 
else
	rmds 
	printmd5syschkerror
fi
if md5sum -c termuxarchchecksum.md5 ; then
	. archsystemconfigs.sh
	. knownconfigurations.sh
	. necessaryfunctions.sh
	. printoutstatements.sh
	rmdsc 
	printf "\n\033[36;1m 🕜 < 🕛 \033[1;34mInstallation script integrity: \033[36;1mOK  \n\033[0m"
else
	rmdsc 
	printmd5syschkerror
fi
}

printmd5syschkerror ()
{
	printf "\033[07;1m\033[31;1m\n 🔆 ERROR md5sum mismatch!  Setup initialization mismatch!\033[36;1m  Update your copy of setupTermuxArch.sh.  If you have updated it, this kind of error can go away, sort of like magic.  Waiting a few minutes before executing again is recommended, especially if you are using a new copy from https://raw.githubusercontent.com/sdrausty/TermuxArch/master/setupTermuxArch.sh on your system.  There are many reasons that generate checksum errors.  Proxies are one reason.  Mirroring and mirrors are another explaination for md5sum errors.  Either way this means,  \"Try again, initialization was not successful.\"  See https://sdrausty.github.io/TermuxArchPlus/md5sums for more information.  \n\n	Run setupTermuxArch.sh again. \033[31;1mExiting...  \n\033[0m"
	exit 
}

printtail ()
{
	printf "\n\033[0mThank you for using \033[1;32m\`setupTermuxArch.sh\`\033[0m 🏁  \n\n\033[0m"'\033]2;  Thank you for using `setupTermuxArch.sh` 📲  \007'
	exit
}

rmdsc ()
{
	rm archsystemconfigs.sh
	rm knownconfigurations.sh
	rm necessaryfunctions.sh
	rm printoutstatements.sh
	rm termuxarchchecksum.md5
}

rmds ()
{
	rm setupTermuxArch.md5
	rm setupTermuxArch.tar.gz
}

# Begin
if [[ $1 = [Dd]* ]];then
	printf "\ndebug wanted\n"
	printtail
elif [[ $1 = [Hh]* ]];then
	printf "\nhelp wanted\n"
	printtail
elif [[ $1 = [Uu]* ]];then
	while true; do
	printf "\n\033[1;31m"
	read -p "Run Arch Linux uninstall? [y|n]  " uanswer
	if [[ $uanswer = [Yy]* ]];then
	printf "\nUninstalling Arch Linux...  \n"
	if [ -e $PREFIX/bin/$bin ] ;then
	       	rm $PREFIX/bin/$bin 
	else 
		printf "Uninstalling Arch Linux, nothing to do for $PREFIX/bin/$bin.\n"
       	fi
	if [ -d $HOME/arch ] ;then
		cd $HOME/arch
		rm -rf * 2>/dev/null||:
		find -type d -exec chmod 700 {} \; 2>/dev/null||:
		cd ..
		rm -rf $HOME/arch
		printf "Uninstalling Arch Linux done.  \n"
	else 
		printf "Uninstalling Arch Linux, nothing to do for $HOME/arch.\n"
	fi
	printtail
	elif [[ $uanswer = [Nn]* ]];then
		printf "\n"
		break
	elif [[ $uanswer = [Qq]* ]];then
		printf "\n"
		break
	else
		printf "\nYou answered \033[33;1m$uanswer\033[1;31m.\n\nAnswer \033[32mYes\033[1;31m or No. [\033[32my\033[1;31m|n]\n"
	fi
	done
	printtail
else
	:
fi

# Main Block
depends
callsystem 
$HOME/arch/root/bin/setupbin.sh ||: 
termux-wake-unlock
rm $HOME/arch/root/bin/setupbin.sh
printfooter
$HOME/arch/$bin ||: 
printtail

