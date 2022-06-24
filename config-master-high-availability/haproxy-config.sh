#!/bin/sh

apt install haproxy -y

cp -f ./config/haproxy.cfg /etc/haproxy/haproxy.cfg

systemctl enable haproxy --now
systemctl restart haproxy