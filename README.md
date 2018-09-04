TermuxArch
===============
[![Join the chat at https://gitter.im/termux](https://badges.gitter.im/termux/termux.svg)](https://gitter.im/termux)

This Termux bash shell script will attempt to set up Arch Linux on Amazon Fire OS, Android and Chromebook using [Termux](https://termux.com).

Install Arch Linux into a Termux PRoot container with [`bash setupTermuxArch.sh`](setupTermuxArch.sh). 

See https://sdrausty.github.io/TermuxArch/docs/install for options how to run [`setupTermuxArch.sh`](https://sdrausty.github.io/TermuxArch/setupTermuxArch.sh) on device.  

This repository uses submodules.  To get all the pieces of this repository run [`scripts/maintenance/pullTermuxArchSubmodules.sh`](scripts/maintenance/pullTermuxArchSubmodules.sh)after cloning in the root directory of this repository.  

* Comments are welcome at https://github.com/sdrausty/TermuxArch/issues ✍ 
* Pull requests are welcome at https://github.com/sdrausty/TermuxArch/pulls ✍ 

Thank you for making this project work better and please contribute 🔆  [Contributors](CONTRIBUTORS.md) and [Notice to Contributors](NOTICE.md) have more information about this project.

由于脚本设置的问题大陆地区用的镜像是台湾的只有几十K/s的速度
所以需要更改系统镜像源
先使用
pkg install vim
安装完成后运行
bash setupTermuxArch.sh manual
按i开始编辑
切换几个镜像源地址为清华tuna地址
mirrors.tuna.tsinghua.edu.cn/archlinuxarm/
其他不用改
最左边右滑长按keyboard调出键盘，按esc
再输入
:wq!
然后脚本就会自动安装，等待即可
