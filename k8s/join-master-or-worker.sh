#!/bin/bash

export IS_MASTER=$1

joinCmd=$(kubeadm token create --print-join-command)
if [ $IS_MASTER != "True" ]; then
	echo $joinCmd
else
	token=$(kubeadm init phase upload-certs --upload-certs)
	token=${token#*:}
	joinCmd=$joinCmd' --control-plane  --certificate-key '$token
	echo $joinCmd
fi
