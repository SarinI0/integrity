#!/usr/bin/env python

import datetime
import time
from os import *
import subprocess
import os

mypath = os.getcwd() + '/log'
os.chdir(mypath)

while 1:
    try:
        now = ''
        tim = str(datetime.datetime.now()).split('.')[0].split(' ')[1]
        ti = tim.split(":")
        for i in range(len(ti) - 1): now += ti[i] + " "
        foo = []
        for (dirpath, dirnames, filenames) in walk(mypath):
            foo.extend(filenames)
        for _ in foo:
            kill = False
            delete = False
            port = ''
            # argv = "sudo tail -1 " + mypath + "/" + _ + " | head -1"
            # data = str(os.popen(argv).read())
            cmd = 'sudo sed -n "1,1000p" ' + _
            result = subprocess.check_output(cmd, shell=True)
            print(result.split('\n'))
            arg = []
            puid = ''
            for item in result.split('\n'):
                if not item == '':
                    if 'pid=' in item:
                        pi = item.split('pid=')[1].split(' ')[0]
                        print(pi)
                        puid = pi
                    arg.append(item)
            R = arg[-1]
            print('\n')
            print(R)
            if ']' in R:
                Y = R.split(']')[0].split(':')
                n = now.split(' ')[1]
                h = now.split(' ')[0]
                k = Y[1]
                try:
                    ee = Y[0].split(' ')[1]
                except:
                    ee = -1
	    	if ( int(k)+7 <= (int(n)+1)) or (int(h) < int(ee)):
                	delete = True
            else:
                kill = True
            print('\n')
            if delete or kill:
                if kill:
                    #os.remove(mypath+'/'+_)
                    continue
                else:
                    execv = "sudo kill -INT " + puid
                    os.system(execv)
                    os.remove(mypath + '/' + _)
        time.sleep(120)
    except KeyboardInterrupt:
        exit(-1)
