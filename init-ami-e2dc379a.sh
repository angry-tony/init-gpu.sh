#!/bin/sh
# ami-e2dc379a  is an AMI on aws with keras, tensorflow, ... pre-installed
# I started using it recently instead of my own custom AMI
# After launching it, just run the below to set it up as per my needs
# ssh file.pem user@ip "wget https://gist.github.com/shadiakiki1986/0c9ea999113691fb9a7ae64e3541fe29/raw/init-ami-e2dc379a.sh -O - | /bin/sh"
##########################

# reload nvidia drivers for GPU
# https://stackoverflow.com/a/45319156/4126114
sudo rmmod nvidia_drm
sudo rmmod nvidia_modeset
sudo rmmod nvidia_uvm
sudo rmmod nvidia
nvidia-smi # should output GPU

# run my init-cpu.sh script
wget https://gist.github.com/shadiakiki1986/0c9ea999113691fb9a7ae64e3541fe29/raw/init-cpu.sh -O - | /bin/sh

# for gpu
pew in G2ML pip install tensorflow-gpu

# other pip
pew in G2ML pip install -U Keras
pew in G2ML pip install hyperas networkx==1.11 statsmodels

# check GPU ok .. should display GPU alongside CPU
pew in G2ML python -c "from tensorflow.python.client import device_lib; print(device_lib.list_local_devices())"