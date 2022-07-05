
import yaml

with open('../config.yml', 'r+') as configYml:
    config = yaml.safe_load(configYml)

    haproxyNodes = config['master-high-availability']['haproxy']['nodes']
    for node in reversed(haproxyNodes):
        nodeName = node['name']
        if nodeName == 'node-1':
            print('remote node-1')
            haproxyNodes.remove(node)
            break

    configYml.seek(0)
    yaml.dump(config, configYml, sort_keys=False)
    configYml.truncate()
