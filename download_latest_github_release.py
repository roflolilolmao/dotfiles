#!/usr/sbin/python

import io
import urllib.request
import sys
import json
import tarfile
import pathlib

from rich import print

url = f'https://api.github.com/repos/{sys.argv[1]}/releases/latest'

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

path = pathlib.Path.home() / '.local/bin'
with urllib.request.urlopen(url) as response:
    with tarfile.open(fileobj=io.BytesIO(response.read())) as tar:
        tar.extractall(path)

print(f'sent to {path}')
