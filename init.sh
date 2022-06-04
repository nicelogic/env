
#!/bin/sh

#config ip first(because may cause reboot)
cd config-ip
./config.py
cd ..

cd config-node-name
./config.py
cd ..

cd base
./base.sh
cd ..

cd config
python3 config.py
if [ $? == 1 ]; then
	echo 'base info not config'
	exit 1
fi
cd ..

cd k8s
./k8s-install.sh
./k8s-env-config.sh
cd ..

cd config/master-high-availability
python3 master-high-availability.py
cd ..