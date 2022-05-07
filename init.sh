
#!/bin/sh

cp -rf sshd/authorized_keys /root/.ssh/authorized_keys 
timedatectl set-timezone Asia/Shanghai

./customize.sh
./base-components.sh
./k8s-env-config.sh