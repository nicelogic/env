
import os
import yaml

configYml = open(r'node-name-config.yml')
config = yaml.safe_load(configYml)
nodeName = config['node-name']
print('node name: ' + nodeName)

if len(nodeName) == 0 :
	print('node name  not config')
	exit(1)

os.system('hostnamectl set-hostname ' + nodeName)
os.system(r"sed -i 's/^127.0.1.1 .*$/127.0.1.1 %s/' /etc/hosts" %(nodeName))


