#!/usr/sbin/python

import io
import urllib.request
import sys
import json
import tarfile
import pathlib

url = f'https://api.github.com/repos/{sys.argv[1]}/releases/latest'

data = json.loads(urllib.request.urlopen(url).read().decode('utf-8'))

url = data['assets'][0]['browser_download_url']
filename = data['assets'][0]['name']

print(f'downloading {url} from {filename}')

path = pathlib.Path.home() / '.local/bin'

with urllib.request.urlopen(url) as response:
    with tarfile.open(fileobj=io.BytesIO(response.read())) as tar:
        tar.extractall(path)

print(f'sent to {path}')
