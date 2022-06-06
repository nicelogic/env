
#!/bin/sh

#---------------------
cd sshd
./sshd.sh
cd ..

#---------------------
cd config-ip
./config.py
if [ $? == 1 ]; then
	echo 'ip not config'
	exit 1
fi
cd ..

#---------------------
cd config-node-name
./config.py
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
cd k8s
./k8s-install.sh
./k8s-env-config.sh
cd ..

#---------------------
cd config-master-high-availability
python3 master-high-availability.py
cd ..