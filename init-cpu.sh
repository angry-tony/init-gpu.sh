#!/bin/sh
# Use this when launching a new server, e.g. AWS spot instance
# ssh file.pem user@ip "wget https://gist.github.com/shadiakiki1986/0c9ea999113691fb9a7ae64e3541fe29/raw/init-cpu.sh -O - | /bin/sh"
#
# If launching a GPU instance, check also init-gpu.sh
# Note: permalink to gist from
# https://gist.github.com/atenni/5604615

export DEBIAN_FRONTEND=noninteractive
sudo apt-get -qq -y update
sudo apt-get -qq -y install python3 python3-pip

sudo pip3 install -U pip
sudo pip3 install pew

# If using tensorboard, will probably want to wait
# until https://github.com/fchollet/keras/pull/7566/files/f2b66a02067cd5a0bc7291231c5fe59f355ff2ad#r134733445
# and use keras 2.0.6 and not 2.0.7
pew new \
  -d \
  -i sklearn \
  -i pandas \
  -i numpy \
  -i scipy \
  -i matplotlib \
  -i Keras \
  -i tensorflow \
  -i h5py \
  -i slackclient \
  -i scikit-image \
  -i jupyter \
  -i jupyterlab \
  -i tensorboard \
  -i hyperas \
  -i networkx==1.11 \
  -i statsmodels \
  G2ML

echo "PS1='# '">>~/.bashrc

mkdir ~/.jupyter/
echo "c.NotebookApp.password = u'sha1:8e63b3cd2b5e:5faf64fbd48ae73d6b14488f181d727326e573b4'" > ~/.jupyter/jupyter_notebook_config.py