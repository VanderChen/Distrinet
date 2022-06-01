#!/bin/bash

sudo apt install python3-dev python3-venv libffi-dev gcc libssl-dev git

python -m pip install --upgrade pip
pip install 'ansible<=2.11'

mkdir ~/kube-cluster \
cd ~/kube-cluster

vim ~/kube-cluster/hosts

systemctl enable  kubelet.service

kubeadm config images pull