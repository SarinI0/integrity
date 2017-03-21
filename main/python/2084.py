#!/usr/bin/python
import os
os.chdir("/home")
os.chdir("/home/rt/botgoat/ruby")
cmd = 'sudo ruby dig.rb -h 46.121.206.221 -p 2084' 
p = os.system('sudo '+cmd)
