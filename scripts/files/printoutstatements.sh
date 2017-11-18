#!/data/data/com.termux/files/usr/bin/bash -e
# Copyright 2017 by SDRausty. All rights reserved.
# Website for this project at https://sdrausty.github.io/TermuxArch 
# See https://sdrausty.github.io/TermuxArch/CONTRIBUTORS Thank You! 
# 🕧🕐🕜🕑🕝🕒🕞🕓🕟🕔🕠🕕🕡🕖🕢🕗🕣🕘🕤🕙🕥🕚🕦🕛
# Printout statement subroutines for `setupTermuxArch.sh`.
################################################################################

printdetectedsystem ()
{
	printf "\n\033[36;1m 🕑 < 🕛 \033[1;34mDetected $(uname -m) " 
	detectsystem2p 
}

printdownloading ()
{
	printf '\033]2;  🕝 < 🕛 Now downloading the system image file and the corresponding checksum.  \007'"\n\033[36;1m 🕝 < 🕛 \033[1;34mNow downloading \033[36;1m$file \033[1;34mand the corresponding checksum.  Activating termux-wake-lock.  \033[37;1mThis may take a long time depending on your Internet connection.  \n\n\033[36;1m"
}

printfooter()
{
	printf "\n\033[36;1m 🕙 < 🕛 \033[0mRun \033[32;1mfinishsetup.sh\033[0m to continue the installation. Alternatively, go on with the installation by doing the following:\n\n	1) Run \033[32;1mlocale-gen\033[0m to generate the en_US.UTF-8 locale.  Edit \033[34;1m/etc/locale.gen \033[0mwith \033[34;1mnano\033[0m or \033[34;1mvi\033[0m specifing your preferred locale and run \033[32;1mlocale-gen\033[0m if you want other locales. See https://wiki.archlinux.org/index.php/Locale for more information.  \n\n	2) Adjust your \033[1;34m/etc/pacman.d/mirrorlist\033[0m file in accordance with your geographic location. Use \033[32;1mpacman -Syu\033[0m to update your Arch Linux in Termux distribution.  See https://wiki.archlinux.org/index.php/Pacman for more information.  \n\n\033[0m"
}

printmd5check ()
{
	printf "\n\033[36;1m 🕠 < 🕛 \033[1;34mChecking download integrity with md5sum.  \033[37;1mThis may take a little while.  \n\n\033[36;1m"
}

printmd5error ()
{
	printf "\n\033[07;1m\033[31;1m 🔆 ERROR md5sum mismatch! The download was corrupt! Removing failed download.\033[36;1m  Run setupTermuxArch.sh again!  See https://sdrausty.github.io/TermuxArchPlus/md5sums for more information.  This kind of error can go away, sort of like magic.  Waiting a few minutes before executing again is recommended. There are many reasons that generate checksum errors.  Proxies are one reason.  Mirroring and mirrors are another explaination for md5sum errors.  Either way it means this download was corrupt.  If this keeps repeating, please change your mirror with an editor like vi in \033[37;1mknownconfigurations.sh\033[36;1m.  See https://sdrausty.github.io/TermuxArchPlus/mirrors for more information.  \n\n	Run setupTermuxArch.sh again. \033[31;1mExiting...  \n\033[0m"
	exit 
}

printmd5success ()
{
	printf '\033]2;  🕡 < 🕛 Now uncompressing the system image file.  This will take much longer!  Be patient.  \007'"\n\033[36;1m 🕕 < 🕛 \033[1;34mDownloaded files integrity: \033[36;1mOK  \n\n\033[36;1m 🕡 < 🕛 \033[1;34mNow uncompressing \033[36;1m$file\033[37;1m.  This will take much longer!  Be patient.  \n\033[0m"
}

printmd5syschksuccess ()
{
	printf "\n\033[36;1m 🕜 < 🕛 \033[1;34mInstallation script integrity: \033[36;1mOK  \n\033[0m"
}

printmismatch ()
{
	printf "\n\033[07;1m\033[31;1m 🔆 ERROR Unknown configuration!  Did not find an architecture and operating system match in\033[37;1m knownconfigurations.sh\033[31;1m!  \033[36;1mDetected $(uname -mo).  There still is hope.  Check at http://mirror.archlinuxarm.org/os/ and https://www.archlinux.org/mirrors/ for other available images and see if any match your device.  If you find a match, then please \033[37;1msubmit a pull request\033[36;1m at https://github.com/sdrausty/TermuxArch/pulls with script modifications.  Alternatively, \033[37;1msubmit a modification request\033[36;1m at https://github.com/sdrausty/TermuxArch/issues if you find a configuration match.  Please include output from \033[37;1muname -mo\033[36;1m on the device in order to expand autodetection for \033[37;1msetupTermuxArch.sh\033[36;1m.  See https://sdrausty.github.io/TermuxArchPlus/Known_Configurations for more information.  \n\n	\033[36;1mRun setupTermuxArch.sh again. \033[31;1mExiting...  \n\033[0m"
	exit 
}

printtail ()
{
	printf '\033]2;  Thank you for using `setupTermuxArch.sh` to install Arch Linux in Termux 📲  \007'"\n\033[36;1m 🕥 < 🕛 \033[0mUse \033[32;1m./arch/$bin\033[0m from your \033[1;34m\$HOME\033[0m directory to launch Arch Linux in Termux for future sessions.   Alternatively copy \033[32;1m$bin\033[0m to your \033[1;34m\$PATH\033[0m which is, \033[1;34m\"$PATH\"\033[0m.  \n\n"
	copybin2path 
	releasewakelock 
	printf "\033[0mThank you for using setupTermuxArch.sh to install Arch Linux in Termux🏁  \033[1;34mExiting...   \n\n\033[0m"
}

