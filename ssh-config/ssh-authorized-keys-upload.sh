
#!/bin/sh

export NODE-IP=192.168.1.101
scp ../../authorized_keys root@${NODE-IP}:/root/.ssh/authorized_keys 
