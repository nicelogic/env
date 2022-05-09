
#!/bin/sh

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