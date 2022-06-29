#!/bin/bash

#---------------------
cd config-node-name
python3 ./config.py | tee ../log/config-node-name
if [ $? == 1 ]; then
	echo 'node name not config'
	exit 1
fi
cd ..

#---------------------
cd 'time'
./time.sh | tee ../log/config-time
cd ..

#---------------------
cd source
./source.sh | tee ../log/config-source
cd ..

#---------------------
cd util 
./util.sh | tee ../log/config-util
cd ..

#---------------------
cd container 
./containerd-init.sh | tee ../log/config-container
cd ..

#---------------------
cd k8s
./k8s-install.sh | tee ../log/k8s-install
./k8s-env-config.sh | tee ../log/k8s-env-config
cd ..

#---------------------
cd config-master-high-availability
python3 config-haproxy.py | tee ../log/config-haproxy
python3 config-keepalived.py | tee ../log/config-keepalived
cd ..

#-------------------
cd k8s

cd first-master
python3 init-master-and-pod-network.py | tee ../../log/init-master
cd ..

cd other-master
python3 join-master-and-update-all-haproxy.py | tee ../../log/other-master
cd ..

cd worker
python3 join-worker.py | tee ../../join-worker
cd ..

cd ..

#-------------------
