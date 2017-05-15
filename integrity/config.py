#!/usr/bin/env python

import os

pt = os.getcwd()
pa = ""
pa += pt + "/singleThread/utils/"
execv = "sudo python " + pa + "insert.py"
os.system(execv)
os.chdir(pa)
os.system("sudo rm insert.py")
os.chdir(pt)


