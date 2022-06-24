#!/bin/bash

joinCmd=`kubeadm token create --print-join-command`
printf "join as worker' cmd:\n"
echo $joinCmd
printf "\n"
printf "join as master's cmd:\n"
token=`kubeadm init phase upload-certs --upload-certs`
token=${token#*:}
joinCmd=$joinCmd' --control-plane  --certificate-key '$token
echo $joinCmd
printf "\n"