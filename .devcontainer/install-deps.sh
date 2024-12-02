#!/usr/bin/env bash

##################################################################################
# Debian bookworm package installation script
# 
# This script is designed to be used on a Dockerfile (for building a docker image)
# as well as to be manually executed (e.g for installing the G5 SW packages in a
# WSL debian development setup environment). Note that the manual exevcution of
# this script requires root/sudo privileges.
# Make sure any changes to this scripts do not comprise the generation of the
# docker image used in the CI/CD pipelines.
#
##################################################################################

set -e 

dpkg --add-architecture arm64

apt-get update
apt-get install -y \
        build-essential \
        crossbuild-essential-arm64 \
        git \
        g++ \
        clang \
        ninja-build \
        cmake \
        gdb-multiarch \
        rsync \
        ccache

apt-get -y upgrade
apt-get -y autoremove
apt-get clean

mkdir -p /usr/share/devcontainer/ && \
    /usr/share/cmake/debtoolchainfilegen arm64 > /usr/share/devcontainer/toolchain_arm64.cmake