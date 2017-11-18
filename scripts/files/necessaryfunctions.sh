#!/data/data/com.termux/files/usr/bin/bash -e
# Copyright 2017 by SDRausty. All rights reserved.
# Website for this project at https://sdrausty.github.io/TermuxArch
# See https://sdrausty.github.io/TermuxArch/CONTRIBUTORS Thank You 
################################################################################

adjustmd5file ()
{
	if [ "$(uname -m)" = "x86_64" ] || [ "$(uname -m)" = "i686" ];then
		wget -q -N --show-progress http://$mirror${path}md5sums.txt
		sed '2q;d' md5sums.txt > $file.md5
		rm md5sums.txt
	else
		wget -q -N --show-progress http://$mirror$path$file.md5
	fi
}

callsystem ()
{
	integratycheck2
	mkdir -p $HOME/arch
	cd $HOME/arch
	detectsystem
}

copybin2path ()
{
	printf " 🕚 \033[36;1m<\033[0m 🕛 "
	while true; do
	read -p "Copy \`$bin\` to your \`\$PATH\`? [y|n]" answer
	if [[ $answer = [Yy]* ]];then
		cp $HOME/arch/$bin $PREFIX/bin
		printf "\n 🕦 \033[36;1m<\033[0m 🕛 Copied \033[32;1m$bin\033[0m to \033[1;34m$PREFIX/bin\033[0m.  "
		break
	elif [[ $answer = [Nn]* ]];then
		printf "\n 🕦 \033[36;1m<\033[0m 🕛 "
		break
	elif [[ $answer = [Qq]* ]];then
		printf "\n 🕦 \033[36;1m<\033[0m 🕛 "
		break
	else
		printf "\n 🕚 \033[36;1m<\033[0m 🕛 You answered \033[33;1m$answer\033[0m.\n"
		printf "\n 🕚 \033[36;1m<\033[0m 🕛 Answer Yes or No (y|n).\n\n"
	fi
	done
}

detectsystem ()
{
	printdetectedsystem
	if [ "$(getprop ro.product.cpu.abi)" = "arm64-v8a" ];then
		aarch64
	elif [ "$(getprop ro.product.cpu.abi)" = "armeabi" ];then
		armv5l
	elif [ "$(getprop ro.product.cpu.abi)" = "armeabi-v7a" ];then
		detectsystem2 
	elif [ "$(getprop ro.product.cpu.abi)" = "x86" ];then
		i686 
	elif [ "$(getprop ro.product.cpu.abi)" = "x86_64" ];then
		x86_64
	else
		printmismatch 
	fi
}

detectsystem2 ()
{
	if [ "$(getprop ro.product.device)" = "*_cheets" ];then
		armv7lChrome 
	else
		armv7lAndroid  
	fi
}

detectsystem2p ()
{
	if [ "$(getprop ro.product.device)" = "*_cheets" ];then
	printf "Chromebook.  \n\033[0m"
	else
	printf "$(uname -o) Operating System.  \n\033[0m"
	fi
}

getimage ()
{
	# Get latest image for x86_64 wants refinement.  __Continue does not work.__  https://stackoverflow.com/questions/15040132/how-to-wget-the-more-recent-file-of-a-directory
	if [ "$(getprop ro.product.cpu.abi)" = "x86_64" ];then
		wget -A tar.gz -m -nd -np http://$mirror$path
	else
		wget -q -c --show-progress http://$mirror$path$file
	fi
}

integratycheck2 ()
{
	if md5sum -c termuxarchchecksum.md5 -s ; then
		rmfiles2  
		printmd5syschksuccess 
	else
		rmfiles2  
		printmd5syschkerror
	fi
}

makebin ()
{
	bin=startarch
	startbin 
	touchupsys 
}

makesystem ()
{
	termux-wake-lock 
	printdownloading 
	adjustmd5file 
	getimage
	printmd5check
	if md5sum -c $file.md5 -s ; then
		printmd5success
		preproot 
	else
		rm -rf $HOME/arch
		printmd5error
	fi
	rm *.tar.gz *.tar.gz.md5
	makebin 
	printfooter
}

preproot ()
{
	if [ "$(uname -m)" = "x86_64" ] || [ "$(uname -m)" = "i686" ];then
		proot --link2symlink bsdtar -xpf $file --strip-components 1 2>/dev/null||:
	else
		proot --link2symlink bsdtar -xpf $file 2>/dev/null||:
	fi
}

releasewakelock ()
{
	printf " 🕦 \033[36;1m<\033[0m 🕛 "
	while true; do
	read -p "Release termux-wake-lock? [y|n]" answer
	if [[ $answer = [Yy]* ]];then
		termux-wake-unlock
		printf "\n 🕛 \033[32;1m=\033[0m 🕛 Termux-wake-lock released.  \033[0m.  "
		break
	elif [[ $answer = [Nn]* ]];then
		printf "\n 🕛 \033[32;1m=\033[0m 🕛 "
		break
	elif [[ $answer = [Qq]* ]];then
		printf "\n 🕛 \033[32;1m=\033[0m 🕛 "
		break
	else
		printf "\n 🕦 \033[36;1m<\033[0m 🕛 You answered \033[33;1m$answer\033[0m.\n"
		printf "\n 🕦 \033[36;1m<\033[0m 🕛 Answer Yes or No (y|n).\n\n"
	fi
	done
}

touchupsys ()
{
	mkdir -p root/bin
	addbashrc 
	addbash_profile 
	addga
	addgcl
	addgcm
	addgp
	addgpl
	addmotd
	addresolv.conf 
	finishsetup
	locale.gen
}

rmfiles2 ()
{
	rm archsystemconfigs.sh
	rm knownconfigurations.sh
	rm necessaryfunctions.sh
	rm printoutstatements.sh
	rm termuxarchchecksum.md5
}

