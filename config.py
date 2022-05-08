
import os
import yaml

configYml = open(r'config.yml')
config = yaml.safe_load(configYml)
nodeName = config['node-name']
localIp = config['local-ip']
print('node name: ' + nodeName)
print('local ip: ' + localIp)


os.system('./customize.sh ' + nodeName + ' ' + localIp)