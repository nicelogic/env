#!/bin/bash

joinCmd=`kubeadm token create --print-join-command`
echo "join as worker' cmd:\n"
echo $joinCmd
echo "\n"
echo "join as master's cmd:\n"
token=`kubeadm init phase upload-certs --upload-certs`
token=$token' --control-plane  --certificate-key '$token