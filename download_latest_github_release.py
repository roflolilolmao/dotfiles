#!/usr/sbin/python

import io
import urllib.request
import sys
import json
import tarfile
import pathlib

from rich import print

release = 'latest'
if len(sys.argv) > 2:
    release = sys.argv[2]

url = f'https://api.github.com/repos/{sys.argv[1]}/releases/{release}'

data = json.loads(urllib.request.urlopen(url).read().decode('utf-8'))

assets = [asset for asset in data['assets']]

while 1:
    for i, a in enumerate(assets):
        print(f'{i + 1}. {a["name"]}')

    try:
        asset = assets[int(input('What file should we download?\n')) - 1]
        break
    except (TypeError, IndexError) as e:
        print(e)

url = asset['browser_download_url']
filename = asset['name']

print(f'downloading {url} from {filename}')

if 'tar.gz' in filename:
    path = pathlib.Path.home() / '.local/bin'
    with urllib.request.urlopen(url) as response:
        with tarfile.open(fileobj=io.BytesIO(response.read())) as tar:
            tar.extractall(path)
    print(f'sent to {path}')
else:
    with urllib.request.urlopen(url) as response:
        with open(filename, 'wb') as output:
            output.write(response.read())
    print('downloaded file')
