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

set -e

# for GPU, install nvidia driver
# ??? Did I miss the: wget http://...nvidia.com/.../...deb
#                and  dpkg -i ...deb
wget http://us.download.nvidia.com/XFree86/Linux-x86_64/384.66/NVIDIA-Linux-x86_64-384.66.run
sudo /bin/sh NVIDIA-Linux-x86_64-384.66.run

# verify nvidia driver installed ok
nvidia-smi -q|head

# install cuda 8
# https://developer.nvidia.com/cuda-downloads
# Requires downloading 2 GB
wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64/cuda-repo-ubuntu1604_8.0.61-1_amd64.deb
sudo dpkg -i cuda-repo-ubuntu1604_8.0.61-1_amd64.deb
sudo apt-get update
sudo apt-get install cuda

# Install nvidia driver + nvidia-cuda development header files
# comment out  nvidia-375 nvidia-375-dev
# not sure if needed
export DEBIAN_FRONTEND=noninteractive
sudo apt-get -qq -y update
sudo apt-get -qq -y install nvidia-cuda-dev

# install nvidia cudnn 6 (works with tensorflow-gpu 1.3.0)
# https://developer.nvidia.com/cudnn
# Log in / Download / Download cuDNN v6.0 (April 27, 2017), for CUDA 8.0 / cuDNN v6.0 Runtime Library for Ubuntu16.04 (Deb)
wget \
  http://developer2.download.nvidia.com/compute/machine-learning/cudnn/secure/v6/prod/8.0_20170427/Ubuntu16_04-x64/libcudnn6_6.0.21-1%2Bcuda8.0_amd64.deb?FJ-9yn3c0yI6peaW7lzlH4amGhYcJoDq1yvNaw8FW5M0n9s1uZwxvlkfQ7roCvVQJZ0TbTZPRFJOuv6cXTWG5QmrGON5SVGtBRlU08suwHCmcvQSmpLo9TFcy9ALmSwe9Y-UGbhPWaUMywCiEebE3IXvoPKsmtaofUaqZ9pRIwdmb3FXD-BIS4Xm1_CGU6oOQSZMPJS8Ng3B1bgi-KCeWJKJ-f2mn_DxLMPyCzbrMOo \
  -O libcudnn6_6.0.21-1%2Bcuda8.0_amd64.deb
sudo dpkg -i libcudnn6_6.0.21-1%2Bcuda8.0_amd64.deb
  
# install tensorflow-gpu
pew in G2ML pip install tensorflow-gpu

# check no trouble with finding libraries
pew in G2ML python -c "import tensorflow"

# check tensorflow can see gpu
# https://stackoverflow.com/a/44547144/4126114
pew in G2ML python -c "from tensorflow.python.client import device_lib; print(device_lib.list_local_devices())"
