#!/bin/bash

#---------------------
cd sshd
./sshd.sh | tee ../log/config-sshd
cd ..

#---------------------
cd config-ip
python3 ./config.py | tee ../log/config-ip
if [ $? == 1 ]; then
	echo 'ip not config'
	exit 1
fi
cd ..