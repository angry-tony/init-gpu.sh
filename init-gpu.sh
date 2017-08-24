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
# https://developer.nvidia.com/cuda-downloads
wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64/cuda-repo-ubuntu1604_8.0.61-1_amd64.deb
sudo dpkg -i cuda-repo-ubuntu1604_8.0.61-1_amd64.deb
sudo apt-get update
sudp apt-get install cuda


# for GPU, install nvidia driver
# ??? Did I miss the: wget http://...nvidia.com/.../...deb
#                and  dpkg -i ...deb
# EDIT: replaced by apt-get install nvidia-375... above
# wget http://us.download.nvidia.com/XFree86/Linux-x86_64/384.66/NVIDIA-Linux-x86_64-384.66.run
# sudo /bin/sh NVIDIA-Linux-x86_64-384.66.run

# install nvidia cudnn
# https://developer.nvidia.com/cudnn
# Log in / Download / Download cuDNN v7.0 (August 3, 2017), for CUDA 8.0 / cuDNN v7.0 Runtime Library for Ubuntu16.04 (Deb)
wget \
  http://developer2.download.nvidia.com/compute/machine-learning/cudnn/secure/v7/prod/8.0_20170802/Ubuntu16_04_x64/libcudnn7_7.0.1.13-1%2Bcuda8.0_amd64.deb?fwTq3D8wejw7jmLp2WZyqpHmjbVj2xAx_JvFPgYYjlJ9f7ODnCNq2jFCzMq_7LslIOnsFVBf6Ev7I7nmUqDrf30c-TzCzDx19c2HVe1v3qOt3_uKQUApYoYPHvWu7-nwxDe93uhELlvR1bnisbknf6x_FxnPJCCTmMIsxB5m8ZBb13yHJucvrbefTo6sSklmCxaP_bPjITMQLdwcRL9o5WLbvwOzIzLQkOv2ohd25VY0IA \
  -O libcudnn7_7.0.1.13-1%2Bcuda8.0_amd64.deb
sudo dpkg -i libcudnn7_7.0.1.13-1%2Bcuda8.0_amd64.deb


# install tensorflow-gpu
pew in G2ML pip install tensorflow-gpu

# verify installations
nvidia-smi -q|head

# check no trouble with finding libraries
pew in G2ML python -c "import tensorflow"

# check tensorflow can see gpu
# https://stackoverflow.com/a/44547144/4126114
pew in G2ML python -c "from tensorflow.python.client import device_lib; print(device_lib.list_local_devices())"
