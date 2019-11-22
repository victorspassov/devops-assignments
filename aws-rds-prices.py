#!/bin/python

import requests
import sys
import io
from io import StringIO
from datetime import datetime
from pathlib import Path
import os

url = 'https://pricing.us-east-1.amazonaws.com/offers/v1.0/aws/AmazonRDS/current/region_index.json'

response = requests.get(url)

response_json = response.json()

regions = response_json.get('regions')

for key in regions.keys():
    print(key)

print("Type your region of choice")

user_input = input()

reg_json = response_json.get('regions').get(f'{user_input}').get('currentVersionUrl')

reg_csv = reg_json.replace('json', 'csv')

reg_url = (f'https://pricing.us-east-1.amazonaws.com{reg_csv}')

data = requests.get(reg_url)

string = data.text

dt = datetime.now().strftime("%d-%m-%YT%H%M")

home = str(Path.home())

if not os.path.exists(f'{home}/aws-prices'):
    os.makedirs(f'{home}/aws-prices')

text_file = open(f'{home}/aws-prices/{dt}_rds.csv', 'w+')
s = io.StringIO(string)
for line in s:
	if 'db.t2' in line:
		text_file.write(line)
text_file.close()