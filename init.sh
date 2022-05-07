
#!/bin/sh

cp -rf sshd/authorized_keys /root/.ssh/authorized_keys 
timedatectl set-timezone Asia/Shanghai

./base-components.sh
./customize.sh
./k8s-env-prepare.sh