#!/bin/sh
# Use this when launching a new server, e.g. AWS spot instance
# ssh file.pem user@ip "wget URL_OF_THIS_GIST -O - | /bin/sh"
#
# If launching a GPU instance, check also init-gpu.sh

export DEBIAN_FRONTEND=noninteractive
sudo apt-get -qq -y update
sudo apt-get -qq -y install python3 python3-pip

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
  -i h5py \
  -i slackclient \
  -i scikit-image \
  -i jupyter \
  -i tensorboard \
  G2ML

echo "PS1='# '">>~/.bashrc

mkdir ~/.jupyter/
echo "c.NotebookApp.password = u'sha1:8e63b3cd2b5e:5faf64fbd48ae73d6b14488f181d727326e573b4'" > ~/.jupyter/jupyter_notebook_config.py