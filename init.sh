#!/bin/sh

#---------------------
cd sshd
./sshd.sh
cd ..

#---------------------
cd config-ip
python3 ./config.py
if [ $? == 1 ]; then
	echo 'ip not config'
	exit 1
fi
cd ..

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
python3 prepare-config-file.py
./haproxy-config.sh
./keepalived-config.sh
cd ..

#-------------------
cd k8s
python3 init-master.py
cd ..

#-------------------
