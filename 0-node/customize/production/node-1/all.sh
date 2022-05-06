
#!/bin/sh

export NODE_IP=192.168.1.101
ssh -T root@${NODE_IP} < ./node-1.sh