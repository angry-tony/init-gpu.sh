#!/bin/sh
# Use this when launching a new server, e.g. AWS GPU spot instance
# ssh file.pem user@ip "wget URL_OF_THIS_GIST -O - | /bin/sh"

export DEBIAN_FRONTEND=noninteractive
sudo apt-get -qq -y update
sudo apt-get -qq -y install python3 python3-pip
sudo pip3 install -U pip
sudo pip3 install pew
pew new \
  -d \
  -i sklearn \
  -i pandas \
  -i numpy \
  -i scipy \
  -i matplotlib \
  -i keras \
  -i tensorflow \
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