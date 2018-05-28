#!/usr/bin/env python3
import requests
import sys
import time
from subprocess import call

# Get the details from the arguments
my_uuid = sys.argv[1]
my_host = sys.argv[2]
my_port = sys.argv[3]

req_url = 'http://%s:%s/check/%s' % (my_host, my_port, my_uuid)
prev = ""

while (True):
    r = requests.get(req_url)
    j = r.json()
    if j["msg"] != prev:
        call(["notify-send", j["msg"]])
        prev = j["msg"]
    time.sleep(1)
