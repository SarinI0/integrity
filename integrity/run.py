#!/usr/bin/env python

import os

uri = raw_input("your website url:")
pt = os.getcwd()
pa = pt + '/singleThread/'
port = raw_input("your login portal jre port:")
local = raw_input("your local machine ip:")
os.system("sudo java -jar " + uri + " " + pa + " " + local)


