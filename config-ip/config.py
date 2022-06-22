
import os
import yaml
import sys

configYml = open(r'../config.yml')
config = yaml.safe_load(configYml)
localIp = config['local-ip']
localIpGateway = config['local-ip-gateway']
networkInterfaceCard = config['network-interface-card']
netplanConfigFilePath = config['netplan-config-file-path']
wifiName = config['wifi']['name'] or ''
wifiPwd = config['wifi']['pwd'] or ''

if localIp is None:
    print('local ip is not config')
    sys.exit(1)
if networkInterfaceCard is None:
    print('network interface card is not config')
    sys.exit(1)
if localIpGateway is None:
    print('local ip gateway is not config')
    sys.exit(1)
if netplanConfigFilePath is None:
    print('netplan config file path is not config')
    sys.exit(1)

os.system('./ip-config.sh ' + localIp + ' ' + networkInterfaceCard +
          ' ' + localIpGateway + ' ' + netplanConfigFilePath + ' ' + wifiName + ' ' + wifiPwd)
