
import os
import yaml
import sys

configYml = open(r'../config.yml')
config = yaml.safe_load(configYml)
localIp= config['local-ip']
if localIp is None:
	print('local ip is not config')
	sys.exit(1)
os.system('./ip-config.sh ' + localIp)
