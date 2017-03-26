#!/usr/bin/python

import requests, time
# from multiprocessing.dummy import Pool as ThreadPool
import shlex, subprocess


class Monitor:

    def __init__(self):
        # command_line = 'sudo python /home/yt/workingLib/django/mysite/NetworkMonitor'
        # args = shlex.split(command_line)
        # p = subprocess.Popen(args)
        self._logging = {}
	self._dup = []

    def local(self):
        log_keys = self.get_hosts()
        Q = []
        for inf in log_keys:
	    if inf not in self._dup:
            	Q.append(("http://freegeoip.net/json/" + str(inf),inf))
		self._dup.append(inf)
        # pool = ThreadPool(len(Q))
        # pool.map(self.search, Q)
        # pool.close()
        # pool.join()
        for q in Q:
            self.search(q[0],q[1])

    def search(self, url, addr):
	time.sleep(2)
        try:
            page = requests.get(url)
            self._logging[addr] = page.content
        except:
            self._logging[addr] = ''

    def __logging__(self):
        return self._logging

    def get_hosts(self):
        with open("/home/yt/workingLib/django/mysite/NetworkMonitor/lgs.txt", mode='r') as log:
            inf = log.read()
            hosts = inf.split('\n')
        return hosts

if __name__ == '__main__':
	Mon = Monitor()
	while 1:
		print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
    		Mon.local()
    		inf = Mon.__logging__()
    		for ip in inf:
        		with open('/home/yt/workingLib/django/mysite/NetworkMonitor/data', mode='a') as hosts:
            			hosts.write(inf[ip]+'\n')
		time.sleep(10)
		print("???????????????????????????????????")

# Open database (will be created if not exists)












