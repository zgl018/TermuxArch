#!/data/data/com.termux/files/usr/bin/sh -e 
# Copyright 2017 (c) all rights reserved 
# by S D Rausty https://sdrausty.github.io
# Update submodules to latest version. 
#####################################################################
cp setupTermuxArch.sh scripts/files/
cd scripts/files/
md5sum *sh > termuxarchchecksum.md5 
cd ../..
bsdtar -czv -f setupTermuxArch.tar.gz --strip-components 2 scripts/files/*
md5sum setupTermuxArch.tar.gz > setupTermuxArch.md5
