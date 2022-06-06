
import re

def replaceText(searchText, replaceText, fileName):
    with open(fileName, 'r') as file:
        data = file.read()
        # data = data.replace(searchText, replaceText)
        data = re.sub(searchText, replaceText, data, flags=re.MULTILINE)
        with open(fileName, 'w') as file:
            file.write(data)