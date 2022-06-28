
import yaml

configYml = open(r'../config.yml')
config = yaml.safe_load(configYml)

#This is the part of the code which filters out the undesired keys
new_yaml = filter(lambda x: x['master-high-availability']['haproxy']['nodes']=='node-2', config) 

with open('./new.yaml', 'w') as file:
    documents = yaml.dump(new_yaml, file)