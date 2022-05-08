
#!/bin/sh

cp -rf sshd/authorized_keys /root/.ssh/authorized_keys 
timedatectl set-timezone Asia/Shanghai

cd config
python3 node-name-config.py
if [ $? == 1 ]; then
	echo 'node name not config'
fi
python3 ip-config.py
if [ $? == 1 ]; then
	echo 'local ip not config'
fi
cd ..

#./base-components.sh
#./k8s-env-config.sh