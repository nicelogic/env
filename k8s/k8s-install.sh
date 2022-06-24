#!/bin/bash

#apt-cache madison kubectl | grep 1.24

apt install -y apt-transport-https ca-certificates curl
apt install -y kubelet=1.24.0-00 kubeadm=1.24.0-00 kubectl=1.24.0-00
apt-mark hold kubelet kubeadm kubectl

echo "k8s install success"