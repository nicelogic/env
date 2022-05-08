
#!/bin/sh

cp -rf sshd/authorized_keys /root/.ssh/authorized_keys 
timedatectl set-timezone Asia/Shanghai

cd config
python3 node-name-config.py
python3 ip-config.py
cd ..

#./base-components.sh
./k8s-env-config.sh