#!/bin/bash

sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
cp -rf authorized_keys /root/.ssh/authorized_keys 
systemctl restart sshd.service