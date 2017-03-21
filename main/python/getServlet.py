#!/usr/bin/python
import os
os.chdir("/home")
os.chdir("/home/rt/botgoat/ruby")
cmd = 'ruby digest.rb -h 46.121.206.221 -p 2087' 
p = os.system('sudo '+cmd)
