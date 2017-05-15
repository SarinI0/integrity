#!/usr/bin/env python

import os, sys, subprocess
import sqlite3

pt = os.getcwd()
path = ''
path += pt + '/db/SQL/'

class Transactions:

    def __init__(self):
        pass

    @staticmethod
    def create(paths):
        conn = sqlite3.connect(paths)
        c = conn.cursor()
        c.execute('''CREATE TABLE ninja
                         (ml text, xyz text, cunt text, nim text, tits text, hom text, fr text, ct text, pl text
                         ,zp text,  iip text )''')
        conn.commit()
        conn.close()

    @staticmethod
    def insert_user(pathd):
        table_name = "ninja"
        args = []
        k = 0
        with open(pathd, mode='r') as Que:
            S = Que.read().split('\n')
            for s in S:
                if k <= 12:
                    if s != '' and not k == 2:
                        args.append(s)
                    else:
                        args.append(s[:-1])
                    k += 1
        args[3] = args[4] + ' ' + args[5]
        f, s = args[:4] , args[6:]
        args = f + s
        argv = repr(tuple(args))
        dbs = [path+'st2.sqlite3', path+'st.sqlite3']
        for db in dbs:
            conn = sqlite3.connect(db)
            c = conn.cursor()
            execv = "INSERT INTO " \
                    "{tn} " \
                    "({ml} , {xyz} , {cunt} , {nim} ," \
                    " {tits}, {hom} , {fr} , {ct} , {pl}, {zp}, {iip}) VALUES" + \
                    argv
            try:
                c.execute(execv. \
                        format(tn=table_name,
                                    ml='ml',
                                    xyz='xyz',
                                    cunt='cunt',
                                    nim='nim',
                                    tits='tits',
                                    hom='hom',
                                    fr='fr',
                                    ct='ct',
                                    pl='pl',
                                    zp='zp',
                                    iip='iip'
                                )
                            )
            except Exception as e:
                print(e)
            conn.commit()
            conn.close()

if __debug__:
	tr = Transactions()
	tr.create(path+"st2.sqlite3")



