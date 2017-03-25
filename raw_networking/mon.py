#!/usr/bin/python

import requests, time
# from multiprocessing.dummy import Pool as ThreadPool
import shlex, subprocess


class Monitor:

    def __init__(self):
        command_line = 'sudo python /Docu' \
                       'ments/NetMon/raw_networking/sn.py'
        args = shlex.split(command_line)
        p = subprocess.Popen(args)
        self._logging = {}

    def local(self):
        time.sleep(15)
        log_keys = self.get_hosts()
        Q = []
        for inf in log_keys:
            Q.append(("http://free"
                      "geoip.net/json/" + str(inf),inf))
        # pool = ThreadPool(len(Q))
        # pool.map(self.search, Q)
        # pool.close()
        # pool.join()
        for q in Q:
            self.search(q[0],q[1])

    def search(self, url, addr):
        try:
            page = requests.get(url)
            self._logging[addr] = repr(page.content)
        except:
            self._logging[addr] = ''

    def __logging__(self):
        return self._logging

    def get_hosts(self):
        with open("/Documents/Ne"
                  "tMon/raw_networking/log", mode='r') as log:
            inf = log.read()
            hosts = inf.split('\n')
        return hosts


if __debug__:
    Mon = Monitor()
    while 1:
        Mon.local()
        inf = Mon.__logging__()
        for ip in inf:
            print(ip, inf[ip])


