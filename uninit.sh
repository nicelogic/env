#!/bin/bash

#---------------------
cd config-master-high-availability
python3 prepare-haproxy-config-file.py
python3 prepare-keepalived-config-file.py
./haproxy-config.sh
./keepalived-config.sh
cd ..

#---------------------
cd delete-node

python3 delete-node.py

cd ..