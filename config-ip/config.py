
import os
import yaml
import sys

configYml = open(r'../config.yml')
config = yaml.safe_load(configYml)
localIp= config['local-ip']
localIpGateway = config['local-ip-gateway']
networkInterfaceCard = config['network-interface-card']
if localIp is None:
	print('local ip is not config')
	sys.exit(1)
if networkInterfaceCard is None:
	print('network interface card is not config')
	sys.exit(1)
if localIpGateway is None:
	print('local ip gateway is not config')
	sys.exit(1)
os.system('./ip-config.sh ' + localIp + ' ' + networkInterfaceCard + ' ' + localIpGateway)
