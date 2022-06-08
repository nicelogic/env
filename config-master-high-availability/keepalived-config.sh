
#!/bin/sh

apt install keepalived -y

cp -f ./config/keepalived.conf /etc/keepalived/keepalived.conf
cp -f ./config/check_apiserver.sh /etc/keepalived/check_apiserver.sh

systemctl enable keepalived --now
systemctl restart keepalived