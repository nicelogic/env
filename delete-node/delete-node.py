
import os
import yaml
import sys

configYml = open(r'../config.yml')
config = yaml.safe_load(configYml)

nodeName = config['node-name']
if nodeName is None:
    print('node name is not config')
    sys.exit(1)

isMasterHighAvailabilityEnable = config['master-high-availability']['enable']
print('master high availability enable: ' +
      str(isMasterHighAvailabilityEnable))

if isMasterHighAvailabilityEnable:
    # delete config.yml haproxy local node, then prepare haproxy cfg
    os.system('cd ../config-master-high-availability')
    os.system('python3 prepare-haproxy-config-file.py')
    os.system('cp -f ./config/haproxy.cfg /etc/haproxy/haproxy.cfg')
    os.system('cd ..')

    print('update other master node haproxy cfg')
    haproxyNodes = config['master-high-availability']['haproxy']['nodes']
    localIp = config['local-ip']
    for node in reversed(haproxyNodes):
        nodeIp = node['ip']
        if nodeIp != localIp:
            os.system('scp /etc/haproxy/haproxy.cfg root@' +
                      nodeIp + ':/etc/haproxy/haproxy.cfg')
            os.system('ssh -T root@' + nodeIp + ' systemctl restart haproxy')

    os.system('systemctl stop keepalived')
    os.system('apt remove keepalived')
    os.system('systemctl stop haproxy')
    os.system('apt remove haproxy')



os.system('./delete-node.sh ' + nodeName)
