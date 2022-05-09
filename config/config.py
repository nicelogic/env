
import os
import yaml
import sys

configYml = open(r'node-name-config.yml')
config = yaml.safe_load(configYml)
nodeName = config['node-name']
print('node name: ' + nodeName)
localIp= config['local-ip']
print('local ip: ' + localIp)

if len(nodeName) == 0 or len(localIp) == 0 :
	sys.exit(1)

os.system('hostnamectl set-hostname ' + nodeName)
os.system(r"sed -i 's/^127.0.1.1 .*$/127.0.1.1 %s/' /etc/hosts" %(nodeName))
os.system('./ip-config.sh ' + localIp)
