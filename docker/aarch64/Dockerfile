FROM ubuntu:xenial-20181005

ENV FORCE_REBUILD_COUNT=1

COPY ros-xenial.list /etc/apt/sources.list.d/
RUN apt-key adv --keyserver hkp://ha.pool.sks-keyservers.net:80 --recv-key 421C365BD9FF1F717815A3895523BAEEB01FA116
RUN apt update
RUN DEBIAN_FRONTEND=noninteractive apt install -y build-essential
RUN DEBIAN_FRONTEND=noninteractive apt install -y cmake
RUN DEBIAN_FRONTEND=noninteractive apt install -y python-configargparse
RUN DEBIAN_FRONTEND=noninteractive apt install -y sbcl
RUN DEBIAN_FRONTEND=noninteractive apt install -y python-nose
RUN DEBIAN_FRONTEND=noninteractive apt install -y python-defusedxml
RUN DEBIAN_FRONTEND=noninteractive apt install -y python-netifaces
RUN DEBIAN_FRONTEND=noninteractive apt install -y python-coverage
RUN DEBIAN_FRONTEND=noninteractive apt install -y google-mock
RUN DEBIAN_FRONTEND=noninteractive apt install -y python-mock
RUN DEBIAN_FRONTEND=noninteractive apt install -y python-empy
RUN DEBIAN_FRONTEND=noninteractive apt install -y python-numpy
RUN DEBIAN_FRONTEND=noninteractive apt install -y python-imaging
RUN DEBIAN_FRONTEND=noninteractive apt install -y python-paramiko
RUN DEBIAN_FRONTEND=noninteractive apt install -y multistrap

ENV TARGET=aarch64-linux-gnu
ENV CROSS_PREFIX=/aarch64-root

RUN DEBIAN_FRONTEND=noninteractive apt install -y gcc-$TARGET
RUN DEBIAN_FRONTEND=noninteractive apt install -y g++-$TARGET
RUN DEBIAN_FRONTEND=noninteractive apt install -y binutils-$TARGET

RUN DEBIAN_FRONTEND=noninteractive apt install -y python-rosdep python-rosinstall-generator python-wstool python-rosinstall

COPY multi.config /etc/
RUN mkdir -p $CROSS_PREFIX
RUN multistrap -a arm64 -f /etc/multi.config -d $CROSS_PREFIX

# Fix symlinks. I assumed that there would be some chroot magic when CMAKE_SYSROOT was set. Doesn't appear to be the case.
RUN find $CROSS_PREFIX -type l -lname '/*' | while read link; do dest=$(readlink $link); echo "$link->$dest"; ln -sfn $CROSS_PREFIX$dest $link; done

RUN rosdep init
