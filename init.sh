
#!/bin/sh

mv sshd/authorized_keys /root/.ssh/authorized_keys 

./base-util.sh
./customize.sh