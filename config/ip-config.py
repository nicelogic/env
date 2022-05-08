
import os
import yaml

configYml = open(r'ip-config.yml')
config = yaml.safe_load(configYml)
localIp= config['local-ip']
print('local ip: ' + localIp)

if len(localIp) == 0 :
	exit(1)

os.system('./ip-config.sh ' + localIp)

