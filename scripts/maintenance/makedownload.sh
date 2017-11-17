#!/bin/sh -e 
# Copyright 2017 by SDRausty. All rights reserved.
# Website for this project at https://sdrausty.github.io/TermuxArch
# See https://sdrausty.github.io/TermuxArch/CONTRIBUTORS Thank You 
################################################################################
cp setupTermuxArch.sh ../..
md5sum *sh > termuxarchchecksum.md5 
#bsdtar -czv -f setupTermuxArch.tar.gz --strip-components 2 scripts/files/*
bsdtar -czv -f ../../setupTermuxArch.tar.gz *
md5sum ../../setupTermuxArch.tar.gz > ../../setupTermuxArch.md5
