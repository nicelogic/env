#!/bin/bash

export alivedMasterNodeIp=$1
export IS_MASTER=$2
echo "alivedMasterNodeIp: $VIP"
echo "is master: $IS_MASTER"

joinCmd=$(ssh -T root@$alivedMasterNodeIp "bash -s" < ../join-master-or-worker.sh $IS_MASTER)
printf "join cmd: \n"
echo $joinCmd

`$joinCmd`