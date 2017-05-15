#!usr/bin/env python
# author: Sarin
# -*- coding: utf-8 -*-

import sys, os


def set_defaultencoding_globally(encoding='utf-8'):
    assert sys.getdefaultencoding() in ('ascii', 'mbcs', encoding)
    import imp
    _sys_org = imp.load_dynamic('_sys_org', 'sys')
    _sys_org.setdefaultencoding(encoding)


set_defaultencoding_globally('utf-8')

import selenium.common.exceptions as Ex
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.common import alert
from selenium.webdriver.common.keys import Keys
import requests, json, time, sys
from bs4 import BeautifulSoup
import html2text
from time import gmtime, strftime
import sqlite3

pt = os.getcwd()
path = ''
path += pt + '/db/SQL/'


class Validate:

    def __init__(self, param=None, geo=None):

        self._db = path + 'db3.sqlite3'
        self._geo = geo
        self._driver = None

        def handle_pop_ups():
            from selenium import webdriver
            from selenium.webdriver.chrome.options import Options
            #path_to_extension = '/..' adblock optional for the bot.. 
            chrome_options = Options()
            # chrome_options.add_argument('load-extension=' + path_to_extension) optional 
            chrome_options.add_argument("--disable-notifications")
	    chrome_options.add_argument("--no-sandbox")
            self._driver = webdriver.Chrome(os.getcwd()+'/chromedriver',chrome_options=chrome_options) 
            self._driver.create_options()

        handle_pop_ups()

        self._ind = (
            ('https://www.linkedin.com/uas/login',
             'session_key-login',
             'session_password-login',
             'signin',
             'https://www.linkedin.com/search/results/index/?keywords=company%20$$$$&origin=GLOBAL_SEARCH_HEADER',
             'h3'),
            ('http://fre'
             'egeoip.net/json/',),
            ('https://www.facebook.c'
             'om/login.php?login_attempt=1&lwv=110',
             'email',
             'pass',
             'loginbutton',
             'https://www.facebook.com/search/str/$$$$/keywords_users',
             '_5d-5'),
            ('http://www.geopostcodes.com',
             'homesearch',
             'i'),
        )
        self._unpack = param
        self._link = [
            'your bot linkedin login', 'pass']
        self._face = ['same for the facebook', '...']
        self._res = []
        self._loc = False
        self._comp = False
        self._comp_city = False
        self._name = False
        self._face_comp = False
        self._comp_count = False
        self._zip_code = []
        self._zip_valid = False
        self._A = 0
        self._B = 0

    def get(self, q =None, param=None, login=False):

        def remove_non_ascii_1(te):
            return ''.join(i for i in te if 32 <= ord(i) < 126)

        if login:

            try:
                self._driver.get(param[0][0])
            except Ex as e:
                return

            username = self._driver.find_element_by_id(param[0][1])
            password = self._driver.find_element_by_id(param[0][2])

            username.send_keys(param[1][0])
            password.send_keys(param[1][1])

            time.sleep(3)
            try:

                self._driver.find_element_by_name(param[0][3]).click()
            except Ex.NoSuchElementException as e:
                del e

                self._driver.find_element_by_id(param[0][3]).click()

            time.sleep(5)

            self._driver.get(param[0][4].split('$$$$')[0]+q+param[0][4].split('$$$$')[1])
            # search =
            # self._driver.Firefox.find_element_by_class_name(param[0][3])
            Not = False
            try:

                # ..
                # is_cunt = self._driver.find_element_by_class_name(param[0][5]).click()
                ind = ''
                if param[0][5] == 'h3':
                    ind = 'comp'

                    is_cunt = self._driver.find_elements_by_tag_name(param[0][5])

                else:
                    ind = 'pers'

                    is_cunt = self._driver.find_elements_by_class_name(param[0][5])

                for i in is_cunt:
                    if (q.lower() in i.text.lower()) or \
                            (q.split(' ')[0] in i.text.lower()) or\
                            (q.split(' ')[1] in i.text.lower()) or (q.split('-')[0] in i.text.lower()) or \
                            (q.split('-')[1] in i.text.lower()):

                        i.click()
                        break
                time.sleep(4)

                content = self._driver.page_source
                # print(content)
                # !!!
                soup = BeautifulSoup(content)
                h = html2text.HTML2Text()

                def remove_non_ascii_1(text):
                    return ''.join(i for i in text if ord(i) < 128)
                h.ignore_links = True
                self._res.append(h.handle(remove_non_ascii_1(content)))
                Not = True
                if ind == 'comp':
                    self._comp = True
                else:
                    for link in soup.findAll('a'):
                        try:
                            ln = str(link.get("href"))
                            if (self._unpack.lower() in ln.lower()) or \
                                (self._unpack.split(' ')[0] in ln.lower()) or \
                                (self._unpack.split(' ')[1] in ln.lower()) or \
                                    (self._unpack.split('-')[0] in ln.lower()) or \
                                    (self._unpack.split('-')[1] in ln.lower()):
                                self._face_comp = True
                        except: pass
                    self._name = True

            except Ex.NoSuchElementException as e:
                del e

            finally:
                if not Not:

                    content = self._driver.page_source
                    soup = BeautifulSoup(content)
                    self._res.append(soup.text)

        else:

            try:
                self._driver.get(param[0][0])
            except Ex as e:
                return

            para = self._driver.find_element_by_id(param[0][1])

            time.sleep(3)
            para.send_keys(q)

            time.sleep(2)
            content = self._driver.page_source
            soup = BeautifulSoup(remove_non_ascii_1(content))

            senity = False

            for i in soup.findAll(param[0][2]):
                try:
                    int(q)
                    self._zip_code += [i]
                    senity = True
                except: pass

            if not senity:
                content = self._driver.page_source
                soup = BeautifulSoup(remove_non_ascii_1(content))
                self._res.append(soup)
            else:
                self._driver.quit()

    def quit(self):
        self._driver.quit()

    def geo_valid(self, geop):
        geo = requests.get(self._ind[1][0]+geop[0])
        content = repr(geo.text)
        if __name__ == '__main__':
            # print(content)
            pass
        if geop[1] in content:
            self._loc = True
        # print(self._loc)
        # !!!

    def com_geo_validate(self, q=None):

        # print(self._res)
        # !!

        if q.lower() in (self._res[self._A].lower()):
            if not self._A and not self._B:
                self._comp_city = True
                self._A += 1
                self._B += 1
            elif self._A == 1 and not self._B:
                self._face_comp = True
                self._A -= 1
            else:
                self._comp_count = True

    def valid(self, query):
	try:
        	self.geo_valid(self._geo)
        	self.get(q=query[0], param=(self._ind[0], self._link), login=True)
        	self.get(q=query[1], param=(self._ind[2], self._face), login=True)
        	self.get(q=query[3], param=(self._ind[3], ''), login=False)
        	self.com_geo_validate(q=query[2])
        	self.com_geo_validate(q=query[0])
        	self.com_geo_validate(q=self._geo[1])
        	if len(self._zip_code) != 0:
            		for z in self._zip_code:
                		ch = str(z).lower()
                		if query[4].lower() in ch:
                    			self._zip_valid = True
                    			break
        	spec = ''
        	prefix = self._geo[0].split('.')
        	for i in range(2):
            		if i == 0:
                		spec += prefix[i] + '.'
            		else:
                		spec += prefix[i]
	except Exception:
        	self._driver.quit()
        	self.quit()

    def __repr__(self):
        k = 0
        money = ''
        g = list()
        g.append((('loc',str(self._loc)),('comp', str(self._comp)),
                  ('comp_loc',str(self._comp_city)),('name',str(self._name)), ('face_comp', str(self._face_comp))
                  , ('comp_count', str(self._comp_count)),('zip',str(self._zip_valid))))
        for spec in g:
            for tech in spec:
                if tech[1] == "True":
                    k += 1
                    money += '$'
        if 4 <= k:
            g.append('return is valid and why ly ly') # here you can extend the module...
        return repr(g)


if __name__ == '__main__':

    def get_args():
        argu = {}
        add = sys.argv[-1]
        with open(add, mode='r') as data:
            args = data.read().split('\n')
        for i in args:
            if i == '':
                del args[args.index(i)]
        print(args)
        for j in range(len(args)):
            if args[j][-1] == ' ':
                args[j] = args[j][:-1]
            if args[j][0] == ' ':
                args[j] = args[j][1:]

        argu['email'] = args[0]
        argu['password'] = args[1]
        argu['country'] = args[2]
        argu['name'] = args[3] + ' ' + args[4]
        argu['title'] = args[5]
        argu['phone'] = args[6]
        argu['company'] = args[7]
        argu['city'] = args[8]
        argu['address'] = args[9].split(' ')[0]
        argu['zip'] = args[10]
        argu['ip'] = args[11]
        argu['mou'] = args[-1]
        return argu

    argum = get_args()
    val = Validate(argum['company'], (argum['ip'], argum['country'],))
    val.valid([argum['company'], argum['name'], argum['city'], argum['zip'], argum['address']])
    paths = sys.argv[-1]
    with open(paths, mode='a') as temp:
        temp.write(val.__repr__())
        temp.write('\n')
        temp.write(str(argum))
    del val
    # print strftime("%Y-%m-%d %H:%M:%S", gmtime())
    exit()






