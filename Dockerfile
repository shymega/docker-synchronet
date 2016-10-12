####################
# Dockerfile for   #
# building a SBBS  #
# image for Docker #
####################

# Set base image
FROM debian:jessie

# Set maintainer.
MAINTAINER shymega <shymega@shymega.org.uk>

# Update aptitude and install packages
# Install packages.

RUN apt-get -yq update
RUN apt-get -yq install build-essential linux-libc-dev \
                        libncurses5-dev libnspr4-dev libcap2-dev gdb \
                        unzip lrzsz gkermit \
                        python pkgconf cvs perl

# Create user
ENV USERNAME docker
RUN useradd -rm -d /docker docker

# Set user
USER "$USERNAME"

# Move to sbbs dir
RUN mkdir -p /docker/sbbs
WORKDIR /docker/sbbs

# Add Makefile
ADD http://cvs.synchro.net/cgi-bin/viewcvs.cgi/*checkout*/install/GNUmakefile \
    /sbbs/GNUmakefile

# Compile
RUN make install SYMLINK=1 CVSTAG=sbbs316c

# Set entrypoint to SBBS
CMD ["/docker/sbbs/exec/sbbs"]
