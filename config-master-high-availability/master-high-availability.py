
import os
import yaml
import sys

configYml = open(r'../config.yml')
config = yaml.safe_load(configYml)
isMasterHighAvailabilityEnable = config['master-high-availability']['enable']
print('master high availability enable: ' + str(isMasterHighAvailabilityEnable))
if not isMasterHighAvailabilityEnable:
	print('master high availability disabled')
	sys.exit(0)

keepAlivedPriority = config['master-high-availability']['keepalived']['priority']
keepAlivedVip = config['master-high-availability']['keepalived']['virtual-ipaddress']
apiServerVip = config['master-high-availability']['keepalived']['check-apiserver']['apiserver-vip']
apiServerDestPort = config['master-high-availability']['keepalived']['check-apiserver']['apiserver-dest-port']
print('keep alived priority: ' + str(keepAlivedPriority))
print('keep alived vip: ' + keepAlivedVip)
print('keep alived api server vip: ' + apiServerVip)
print('keep alived api server dest port: ' + str(apiServerDestPort))



# if nodeName is None 
# or localIp is None == 0 
# or :
# 	sys.exit(1)

# print('node name: ' + nodeName)
# os.system('hostnamectl set-hostname ' + nodeName)
# os.system(r"sed -i 's/^127.0.1.1 .*$/127.0.1.1 %s/' /etc/hosts" %(nodeName))
# os.system('./ip-config.sh ' + localIp)
