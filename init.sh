
#!/bin/sh

sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
cp -rf sshd/authorized_keys /root/.ssh/authorized_keys 
systemctl restart sshd.service
timedatectl set-timezone Asia/Shanghai

cd config
python3 config.py
if [ $? == 1 ]; then
	echo 'base info not config'
	exit 1
fi
cd ..

#./base-components.sh
#./k8s-env-config.sh