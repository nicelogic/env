
import os
import yaml
import sys

with open('../config.yml', 'r+') as configYml:
    config = yaml.safe_load(configYml)
    localNodeName = config['node-name']
    if localNodeName is None:
        print('node name is not config')
        sys.exit(1)

    isMasterHighAvailabilityEnable = config['master-high-availability']['enable']
    print('master high availability enable: ' +
          str(isMasterHighAvailabilityEnable))
    if isMasterHighAvailabilityEnable:
        haproxyNodes = config['master-high-availability']['haproxy']['nodes']
        if haproxyNodes is not None:
            for node in reversed(haproxyNodes):
                nodeName = node['name']
                if nodeName == localNodeName:
                    print('remove local node: ' + nodeName)
                    haproxyNodes.remove(node)
                    break
            configYml.seek(0)
            yaml.dump(config, configYml, sort_keys=False)
            configYml.truncate()

            os.chdir('../config-master-high-availability')
            os.system('python3 config-haproxy.py')
            #os.system('cp -f ./config/haproxy.cfg /etc/haproxy/haproxy.cfg')
            os.chdir('../delete-node')

            print('update other master node haproxy cfg')
            haproxyNodes = config['master-high-availability']['haproxy']['nodes']
            localIp = config['local-ip']
            for node in reversed(haproxyNodes):
                nodeIp = node['ip']
                if nodeIp != localIp:
                    os.system('scp /etc/haproxy/haproxy.cfg root@' +
                              nodeIp + ':/etc/haproxy/haproxy.cfg')
                    os.system('ssh -T root@' + nodeIp +
                              ' systemctl restart haproxy')

            os.system('systemctl stop keepalived')
            os.system('apt remove keepalived')
            os.system('systemctl stop haproxy')
            os.system('apt remove haproxy')

    os.system('./delete-node.sh ' + localNodeName)
