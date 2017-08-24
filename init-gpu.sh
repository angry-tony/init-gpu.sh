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

export DEBIAN_FRONTEND=noninteractive
sudo apt-get -qq -y update
sudo apt-get -qq -y install nvidia-cuda-dev nvidia-375 nvidia-375-dev

# for GPU, install nvidia driver
# ??? Did I miss the: wget http://...nvidia.com/.../...deb
#                and  dpkg -i ...deb
# EDIT: replaced by apt-get install nvidia-375... above
# wget http://us.download.nvidia.com/XFree86/Linux-x86_64/384.66/NVIDIA-Linux-x86_64-384.66.run
# sudo /bin/sh NVIDIA-Linux-x86_64-384.66.run

# Installing CUDA8 required 2GB free space, and my EC2 /dev/xvda was only 8GB
# Instead of downloading CUDA8, and since I already had CUDA7.5, just use tensorflow version 1.2.0
# https://stackoverflow.com/a/44993396/4126114
pew new \
  -d \
  -i tensorflow==1.2.0 \
  -i tensorflow-gpu \
  G2ML