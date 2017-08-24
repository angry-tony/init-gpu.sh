#!/bin/sh
# Run this AFTER init-cpu.sh
# Notes
# - apt-get ... nvidia-*
#    - https://stackoverflow.com/a/45725925/4126114
#    - slowest command, takes 2-3 mins
#    - requires `export LD_LIBRARY_PATH=/usr/lib/x86_64-linux-gnu/`
#      - https://stackoverflow.com/a/43568508/4126114
#    - removed `nvidia-375 nvidia-375-dev` because tensorflow 1.3.0 asks for libcusolver.8.0.so
#      - https://stackoverflow.com/a/44993396/4126114
# - tensorflow-gpu
# - wget ...nvidia.com...
#
# Installing CUDA8 required 2GB free space, and the default EC2 /dev/xvda has only 8GB
# Pay attention to increasing this beforehand
# Ref: https://stackoverflow.com/a/44993396/4126114
#--------------------------------------------------

# Install nvidia driver + nvidia-cuda development header files
export DEBIAN_FRONTEND=noninteractive
sudo apt-get -qq -y update
sudo apt-get -qq -y install nvidia-cuda-dev nvidia-375 nvidia-375-dev

# install cuda 8
wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64/cuda-repo-ubuntu1604_8.0.61-1_amd64.deb
sudo dpkg -i cuda-repo-ubuntu1604_8.0.61-1_amd64.deb


# for GPU, install nvidia driver
# ??? Did I miss the: wget http://...nvidia.com/.../...deb
#                and  dpkg -i ...deb
# EDIT: replaced by apt-get install nvidia-375... above
# wget http://us.download.nvidia.com/XFree86/Linux-x86_64/384.66/NVIDIA-Linux-x86_64-384.66.run
# sudo /bin/sh NVIDIA-Linux-x86_64-384.66.run

# install tensorflow-gpu
pew in G2ML pip install tensorflow-gpu