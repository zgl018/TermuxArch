#!/data/data/com.termux/files/usr/bin/bash -e
# Website for this project at https://sdrausty.github.io/TermuxArch
# See https://sdrausty.github.io/TermuxArch/CONTRIBUTORS Thank You! 
# Copyright 2017 by SDRausty. All rights reserved.  🌎 🌍 🌏 🌐 🗺
# If you are encountering issues with the system-image.tar.gz file regarding download time, repository website connection and/or md5 checksum error, edit this script and change $mirror to your desired geographic location in knownconfigurations.sh.  Before editing this file, ensure termux-wake-lock is running during script operation and that you have a stable Internet connection. 
################################################################################

depend ()
{
	printf '\033]2;  Thank you for using `setupTermuxArch.sh` 📲 \007'"\n 🕛 \033[36;1m< 🕛 This setup script will attempt to set Arch Linux up in your Termux environment.  When successfully completed, you will be enjoying the bash prompt in Arch Linux in Termux on your smartphone or tablet.  If you do not see 🕐 one o'clock below after updating Termux and installing the required components for Arch Linux in Termux installation is completed, run this script again. You might want to check your Internet connection too.  \033[37;1m\n\n	1)	Checking Termux for necessary components.  \n\n"
	if [ ! -f $PREFIX/bin/proot ]; then
		update
	elif [ ! -f $PREFIX/bin/bsdtar ]; then
		update
	elif [ ! -f $PREFIX/bin/wget ]; then
		update
	else
		printf "		Requirements satisfied.  \n\n" 
	fi
	printf "	2)	Installing the script components for Arch Linux in Termux installation.  \n\n"
	# $TMPDIR + tar.gz 
	wget -q -N --show-progress https://raw.githubusercontent.com/sdrausty/TermuxArch/master/archsystemconfigs.sh
	wget -q -N --show-progress https://raw.githubusercontent.com/sdrausty/TermuxArch/master/knownconfigurations.sh
	wget -q -N --show-progress https://raw.githubusercontent.com/sdrausty/TermuxArch/master/necessaryfunctions.sh
	wget -q -N --show-progress https://raw.githubusercontent.com/sdrausty/TermuxArch/master/printoutstatements.sh
	wget -q -N --show-progress https://raw.githubusercontent.com/sdrausty/TermuxArch/master/setupTermuxArch.sh
	wget -q -N --show-progress https://raw.githubusercontent.com/sdrausty/TermuxArch/master/termuxarchchecksum.md5
	. ./archsystemconfigs.sh
	. ./knownconfigurations.sh
	. ./necessaryfunctions.sh
	. ./printoutstatements.sh
	printf "	3)	Activating termux-wake-lock.  \n\n"
	termux-wake-lock # Before activating termux-wake-lock, setupTermuxArch.sh should check whether activation is necessary.
}

update ()
{
	apt-get -qq update && apt-get -qq upgrade --yes
	apt-get -qq install bsdtar proot wget --yes 
	printf "		Requirements satisfied.  \n\n" 
}

# Main Block
depend 
callsystem 
$HOME/arch/$bin ||: # This call should be replaced with a PRoot function that completes setup from within Arch Linux similar to $bin without actually logging the user into the Arch Linux CLI (run a couple of commands, then complete setting up Arch Linux on device). 
printtail
exit 

