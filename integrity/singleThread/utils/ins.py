#!usr/bin/env python
# author: Sarin
# -*- coding: utf-8 -*-

import os, sys, subprocess
import pandas as pd
import sqlite3

pt = os.getcwd()
path = ''
path += pt + '/db/SQL/'


class Transactions:

    def __init__(self):
        pass

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
        dbs = [path+'st2.sqlite3']
        for db in dbs:
	    print "...."
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

if __name__ == '__main__':
    if '_krs_' in sys.argv:
        pwd = sys.argv[-1]
        tr = Transactions()
        tr.insert_user(pwd)

    exit(0)

