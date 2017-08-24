#!/bin/sh
# Use this when launching a new server, e.g. AWS GPU spot instance
# ssh file.pem user@ip "wget URL_OF_THIS_GIST -O - | /bin/sh"
#
# In the below, the following are for running on gpu:
# - nvidia-cuda-dev
# - tensorflow-gpu
# - wget ...nvidia.com...

export DEBIAN_FRONTEND=noninteractive
sudo apt-get -qq -y update
sudo apt-get -qq -y install python3 python3-pip nvidia-cuda-dev

# for GPU, install nvidia driver
# ??? Did I miss the: wget http://...nvidia.com/.../...deb
#                and  dpkg -i ...deb
wget http://us.download.nvidia.com/XFree86/Linux-x86_64/384.66/NVIDIA-Linux-x86_64-384.66.run
sudo /bin/sh NVIDIA-Linux-x86_64-384.66.run

sudo pip3 install -U pip
sudo pip3 install pew

# until https://github.com/fchollet/keras/pull/7566/files/f2b66a02067cd5a0bc7291231c5fe59f355ff2ad#r134733445
# use keras 2.0.6 and not 2.0.7
pew new \
  -d \
  -i sklearn \
  -i pandas \
  -i numpy \
  -i scipy \
  -i matplotlib \
  -i Keras==2.0.6 \
  -i tensorflow \
  -i tensorflow-gpu \
  -i h5py \
  -i slackclient \
  -i scikit-image \
  -i jupyter \
  -i tensorboard \
  G2ML

echo "PS1='# '">>~/.bashrc

sudo mkdir /mnt/ec2vol && sudo chown ubuntu:ubuntu /mnt/ec2vol -R
sudo mount /dev/xvdf /mnt/ec2vol/

mkdir ~/.jupyter/
echo "c.NotebookApp.password = u'sha1:8e63b3cd2b5e:5faf64fbd48ae73d6b14488f181d727326e573b4'" > ~/.jupyter/jupyter_notebook_config.py