
import os
import yaml
import sys

configYml = open(r'../config.yml')
config = yaml.safe_load(configYml)
nodeName = config['node-name']

if nodeName is None:
	print('node name is not config')
	sys.exit(1)

print('node name: ' + nodeName)
os.system('hostnamectl set-hostname ' + nodeName)
os.system(r"sed -i 's/^127.0.1.1 .*$/127.0.1.1 %s/' /etc/hosts" %(nodeName))
os.system('./ip-config.sh ' + localIp)
