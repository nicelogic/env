#!/bin/bash

#---------------------
cd delete-node

python3 delete-node.py ｜ tee ../log/delete-node.log

cd ..