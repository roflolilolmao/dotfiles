#!/usr/sbin/python

import io
import urllib.request
import sys
import json
import tarfile
import pathlib

from rich import print

release = 'latest'
if len(sys.argv) > 3:
    release = sys.argv[3]

url = f'https://api.github.com/repos/{sys.argv[1]}/releases/{release}'

print(f'Probing {url}')

data = json.loads(urllib.request.urlopen(url).read().decode('utf-8'))

assets = [asset for asset in data['assets']]

if len(sys.argv) > 2:
    for a in data['assets']:
        if a['name'] == sys.argv[2]:
            asset = a
            break
    else:
        raise ValueError('oh no')
else:
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

path = pathlib.Path.home() / '.local/bin'
if 'tar.gz' in filename:
    with urllib.request.urlopen(url) as response:
        with tarfile.open(fileobj=io.BytesIO(response.read())) as tar:
            tar.extractall(path)
    print(f'sent to {path}')
else:
    with urllib.request.urlopen(url) as response:
        with open(path / filename, 'wb') as output:
            output.write(response.read())
    print('downloaded file')
