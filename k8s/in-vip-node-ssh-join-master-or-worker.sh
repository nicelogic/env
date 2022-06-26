#!/bin/bash

export VIP=$1
export IS_MASTER=$2
echo "vip: $VIP"
echo "is master: $IS_MASTER"

joinCmd=$(ssh -T root@$VIP "bash -s" < ../join-master-or-worker.sh $IS_MASTER)
printf "join cmd: \n"
echo $joinCmd

`$joinCmd`