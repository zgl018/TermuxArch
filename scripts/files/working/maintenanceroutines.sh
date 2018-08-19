#!/bin/env bash
# Copyright 2017-2018 by SDRausty. All rights reserved.  🌎 🌍 🌏 🌐 🗺
# Hosting https://sdrausty.github.io/TermuxArch courtesy https://pages.github.com
# https://sdrausty.github.io/TermuxArch/CONTRIBUTORS Thank you for your help.  
# https://sdrausty.github.io/TermuxArch/README has information about this project. 
################################################################################

# 			cp setupTermuxArch.sh "${wdir}setupTermuxArch.sh"
sysinfo() {
	spaceinfo
	printf "\\n\\e[1;32mGenerating TermuxArch system information; Please wait…\\n" 
	systeminfo # & spinner "Generating" "System Info…" 
	printf "\\nEnd \`setupTermuxArchSysInfo$stime.log\` system information.\\n\\n\\e[0mShare this information along with your issue at https://github.com/sdrausty/TermuxArch/issues; include input and output.  This file is found in "${wdir}setupTermuxArchSysInfo${stime}.log".  If you think screenshots will help in a quicker resolution, include them in your post as well.  \\n" >> "${wdir}setupTermuxArchSysInfo${stime}".log
	cat "${wdir}setupTermuxArchSysInfo${stime}".log
	printf "\\n\\e[1mSubmit this information if you plan to open up an issue at https://github.com/sdrausty/TermuxArch/issues to improve \`setupTermuxArch.sh\` along with a screenshot of your topic.  Include information about input and output.  \\n\\n"
	exit
}

systeminfo () {
	printf "\\n\\e[1;32m"
	printf "Begin TermuxArch system information.\\n" > "${wdir}setupTermuxArchSysInfo${stime}".log
	printf "\\n\`termux-info\` results:\\n\\n" >> "${wdir}setupTermuxArchSysInfo${stime}".log
	termux-info >> "${wdir}setupTermuxArchSysInfo${stime}".log
	printf "\\nDisk report $usrspace on /data $(date)\\n\\n" >> "${wdir}setupTermuxArchSysInfo${stime}".log 
	for n in 0 1 2 3 4 5 
	do 
		echo "BASH_VERSINFO[$n] = ${BASH_VERSINFO[$n]}"  >> "${wdir}setupTermuxArchSysInfo${stime}".log
	done
	printf "\\ncat /proc/cpuinfo results:\\n\\n" >> "${wdir}setupTermuxArchSysInfo${stime}".log
	cat /proc/cpuinfo >> "${wdir}setupTermuxArchSysInfo${stime}".log
	printf "\\ndpkg --print-architecture result:\\n\\n" >> "${wdir}setupTermuxArchSysInfo${stime}".log
	dpkg --print-architecture >> "${wdir}setupTermuxArchSysInfo${stime}".log
	printf "\\ngetprop ro.product.cpu.abi result:\\n\\n" >> "${wdir}setupTermuxArchSysInfo${stime}".log
	getprop ro.product.cpu.abi >> "${wdir}setupTermuxArchSysInfo${stime}".log
	printf "\\ngetprop ro.product.device result:\\n\\n" >> "${wdir}setupTermuxArchSysInfo${stime}".log
	getprop ro.product.device >> "${wdir}setupTermuxArchSysInfo${stime}".log
	printf "\\nDownload directory information results.\\n\\n" >> "${wdir}setupTermuxArchSysInfo${stime}".log
	if [[ -d /sdcard/Download ]]; then echo "/sdcard/Download exists"; else echo "/sdcard/Download not found"; fi >> "${wdir}setupTermuxArchSysInfo${stime}".log 
	if [[ -d /storage/emulated/0/Download ]]; then echo "/storage/emulated/0/Download exists"; else echo "/storage/emulated/0/Download not found"; fi >> "${wdir}setupTermuxArchSysInfo${stime}".log
	if [[ -d $HOME/downloads ]]; then echo "$HOME/downloads exists"; else echo "~/downloads not found"; fi >> "${wdir}setupTermuxArchSysInfo${stime}".log 
	if [[ -d $HOME/storage/downloads ]]; then echo "$HOME/storage/downloads exists"; else echo "$HOME/storage/downloads not found"; fi >> "${wdir}setupTermuxArchSysInfo${stime}".log 
	printf "\\ndf $installdir results:\\n\\n" >> "${wdir}setupTermuxArchSysInfo${stime}".log
	df "$installdir" >> "${wdir}setupTermuxArchSysInfo${stime}".log 2>/dev/null ||:
	printf "\\ndf results:\\n\\n" >> "${wdir}setupTermuxArchSysInfo${stime}".log
	df >> "${wdir}setupTermuxArchSysInfo${stime}".log 2>/dev/null ||:
	printf "\\ndu -hs $installdir results:\\n\\n" >> "${wdir}setupTermuxArchSysInfo${stime}".log
	du -hs "$installdir" >> "${wdir}setupTermuxArchSysInfo${stime}".log 2>/dev/null ||:
	printf "\\nls -al $installdir results:\\n\\n" >> "${wdir}setupTermuxArchSysInfo${stime}".log
	ls -al "$installdir" >> "${wdir}setupTermuxArchSysInfo${stime}".log 2>/dev/null ||:
	printf "\\nuname -a results:\\n\\n" >> "${wdir}setupTermuxArchSysInfo${stime}".log
	uname -a >> "${wdir}setupTermuxArchSysInfo${stime}".log
}

copyimage() { # A systemimage.tar.gz file can be used: `setupTermuxArch.sh ./[path/]systemimage.tar.gz` and `setupTermuxArch.sh /absolutepath/systemimage.tar.gz`
	cfile="${1##/*/}" 
 	file="$cfile" 
	if [[ "$lc" = "" ]];then
		cp "$1".md5  "$installdir" # & spinner "Copying" "…" 
		cp "$1" "$installdir" # & spinner "Copying" "…" 
	elif [[ "$lc" = "1" ]];then
		cp "$idir/$cfile".md5  "$installdir" # & spinner "Copying" "…" 
		cp "$idir/$cfile" "$installdir" # & spinner "Copying" "…" 
	fi
}

loadimage() { 
	set +Ee
	namestartarch 
 	spaceinfo
	printf "\\n" 
	wakelock
	prepinstalldir 
	copyimage "$@"
	printmd5check
	md5check
	printcu 
	rm -f "$installdir"/*.tar.gz "$installdir"/*.tar.gz.md5
	printdone 
	printconfigup 
	touchupsys 
	printf "\\n" 
	wakeunlock 
	printfooter
	"$installdir/$startbin" ||:
	"$startbin" help
	printfooter2
}

refreshsys() { # Refreshes
	printf '\033]2; setupTermuxArch.sh refresh 📲 \007'
	nameinstalldir 
	namestartarch  
	setrootdir  
	mkdir -p "$installdir"/root/bin
	if [[ ! -d "$installdir" ]] || [[ ! -f "$installdir"/bin/env ]];then
		printf "\\n\\e[0;33m%s\\e[1;33m%s\\e[0;33m.\\e[0m\\n" "The root directory structure is incorrect; Cannot continue " "setupTermuxArch.sh refresh"
		exit $?
	fi
	cd "$installdir"
	addREADME
	addae
	addauser
	addauserps
	addauserpsc
	addbash_logout 
	addbash_profile 
	addbashrc 
	addcdtd
	addcdth
	addch 
	adddfa
	addexd
	addfake_proc_stat
	addfake_proc_shmem
	addfibs
	addga
	addgcl
	addgcm
	addgp
	addgpl
	addkeys
	addmotd
	addmoto
	addpc
	addpci
	addprofile 
	addresolvconf 
	addt 
	addthstartarch
	addtour
	addtrim 
	addyt 
	addwe  
	addv 
	makefinishsetup
	makesetupbin 
	makestartbin 
	setlocale
	printf "\\n" 
	wakelock
	printf '\033]2; setupTermuxArch.sh refresh 📲 \007'
	printf "\\n\\e[1;32m==> \\e[1;37m%s \\e[1;32m%s %s 📲 \\a\\n" "Running" "$(basename "$0")" "$args" 
	"$installdir"/root/bin/setupbin.sh 
 	rm -f root/bin/finishsetup.sh
 	rm -f root/bin/setupbin.sh 
	printf "\\e[1;34mThe following files have been updated to the newest version.\\n\\n\\e[0;32m"
	ls "$installdir/$startbin" |cut -f7- -d /
	ls "$installdir"/bin/we |cut -f7- -d /
	ls "$installdir"/root/bin/* |cut -f7- -d /
	printf "\\n" 
	wakeunlock 
	printfooter 
	printf "\\a"
	"$installdir/$startbin" ||:
	"$startbin" help
	printfooter2
	exit
}

#EOF
