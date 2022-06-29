#!/bin/bash

#---------------------
cd sshd
./sshd.sh
cd ..

#---------------------
cd config-ip
python3 ./config.py
if [ $? == 1 ]; then
	echo 'ip not config'
	exit 1
fi
cd ..