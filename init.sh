
#!/bin/sh

cp -rf sshd/authorized_keys /root/.ssh/authorized_keys 

./base-components.sh
./customize.sh