#!/bin/bash

export IS_MASTER=$1

joinCmd=`kubeadm token create --print-join-command`
if [ $IS_MASTER != "True" ]; then

printf "join as worker' cmd:\n"
printf "\n"
echo $joinCmd
printf "\n"

else

printf "join as master's cmd:\n"
printf "\n"
token=`kubeadm init phase upload-certs --upload-certs`
token=${token#*:}
joinCmd=$joinCmd' --control-plane  --certificate-key '$token
# echo $joinCmd
printf "\n"

fi

exit $joinCmd