#!/bin/bash

#---------------------
cd config-node-name
python3 ./config.py
if [ $? == 1 ]; then
	echo 'node name not config'
	exit 1
fi
cd ..

#---------------------
cd 'time'
./time.sh
cd ..

#---------------------
cd source
./source.sh
cd ..

#---------------------
cd util
./util.sh
cd ..

#---------------------
cd container
./containerd-init.sh
cd ..

#---------------------
cd k8s
./k8s-install.sh
./k8s-env-config.sh
cd ..

#---------------------
cd config-master-high-availability
python3 config-haproxy.py
python3 config-keepalived.py
cd ..

#-------------------
cd k8s

cd first-master
python3 init-master-and-pod-network.py
cd ..

cd other-master
python3 join-master-and-update-all-haproxy.py
cd ..

cd worker
python3 join-worker.py
cd ..

cd ..

#-------------------
