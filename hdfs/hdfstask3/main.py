import subprocess
import sys
from sys import argv
import commands

PathArg = sys.argv[1]

def Parse(response):
        from_index = response.index("Total blocks (validated):")
        for_index = response.index("(avg. block size")
        return response[from_index + len("Total blocks (validated):"):for_index]

def RunCMD(PathArg):
        cmd = "hdfs fsck " + PathArg
        response = commands.getoutput(cmd)
        return Parse(response)

server_name = RunCMD(PathArg)

print(server_name.strip())
