
import os
import yaml

configYml = open(r'config.yml')
config = yaml.safe_load(configYml)
nodeName = config['node-name']
localIp = config['local-ip']
print('node name: ' + nodeName)
print('local ip: ' + localIp)

if len(nodeName) == 0 or len(localIp) == 0 :
	print('node name or local ip not config')
	exit(1)


os.system('./customize.sh ' + nodeName + ' ' + localIp)