#!/bin/bash

apt-get -yq update
apt-get -yq install wget \
        make g++ \
        linux-libc-dev \
        libncurses5-dev \
        libnspr4-dev \
        libcap2-dev \
        gdb \
        zip unzip \
        lrzsz \
        build-essential \
        gkermit python \
        pkgconf cvs \
        perl

# Create SBBS directory
mkdir -p /sbbs
cd /sbbs || exit 1

# Verify we are in the right directory.
if [[ ! "$(pwd)" == "/sbbs" ]]; then
    echo "Not in /sbbs!"
    exit 1
fi

# Grab the Makefile from CVS

wget \
    'http://cvs.synchro.net/cgi-bin/viewcvs.cgi/*checkout*/install/GNUmakefile'

make install SYMLINK=1 CVSTAG=sbbs316c

# Install the init.d script

wget \
    "http://cvs.synchro.net/cgi-bin/viewcvs.cgi/*checkout*/install/init.d/sbbs.debian"
