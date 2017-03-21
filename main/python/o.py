#!/usr/bin/python
import random
#k = ["https://botgoat.com:2084/get?url=http://","https://botgoat.com:2087/get?url=https://", "cloudflare","akamai","ynet","wix","google"] 
#i = ["https://botgoat.com:2083/get?url=https://", "https://botgoat.com:2088/get?query=","https://botgoat.com:2086/get?query="]

k = ["https://botgoat.com/dogma/get?url=http://","https://botgoat.com/sonia/get?url=https://", "cloudflare","akamai","ynet","wix","google"] 
i = [ "https://botgoat.com/juls/get?res=repr","https://botgoat.com/moon/get?query=","https://botgoat.com/anja/get?url=https://"]

e = []
w = []
a=''
for u in k:
	for j in range(len(u)):
		a += str(ord(u[j]))+chr(random.randint(58,78))
        e.append(a)
        a=''
for u in i:
	for j in range(len(u)):
		a += str(ord(u[j]))+chr(random.randint(66,78))
        w.append(a)
        a=''

print e
print "\n\n\n"
print w

