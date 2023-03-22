import subprocess
import sys
from sys import argv
import commands
import requests
import os

PathArg = sys.argv[1]

def Parse(response):
        from_index = response.index("http://")
        for_index = response.index(":50075")
        return response[from_index + len("http://"):for_index]

def RunCMD(PathArg):
	url = "http://mipt-master.atp-fivt.org:50070/webhdfs/v1" + PathArg  + "?op=OPEN"
	cmd = "curl -i -s " + url
	response = os.popen(cmd)
	return response.read()
response = RunCMD(PathArg)
print(Parse(response))
