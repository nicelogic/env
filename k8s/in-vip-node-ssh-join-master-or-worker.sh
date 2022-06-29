#!/bin/bash

export alivedMasterNodeIp=$1
export IS_MASTER=$2
echo "alivedMasterNodeIp: $alivedMasterNodeIp"
echo "is master: $IS_MASTER"

joinCmd=$(ssh -T root@$alivedMasterNodeIp "bash -s" < ../join-master-or-worker.sh $IS_MASTER)
printf "join cmd: \n"
echo $joinCmd

`$joinCmd`

mkdir -p $HOME/.kube
if [ "$IS_MASTER" == "False" ];then
    sudo scp root@$alivedMasterNodeIp:/etc/kubernetes/admin.conf $HOME/.kube/config
else
    sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
fi
sudo chown $(id -u):$(id -g) $HOME/.kube/config