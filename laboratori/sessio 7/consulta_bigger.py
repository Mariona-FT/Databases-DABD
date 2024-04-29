#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import sqlite3
from random import randint
from datetime import datetime

atypes = ('C','L','S')
vowels = ('a','e','i','o','u')
somecons = ('b','d','f','k','l','m','p','r','s')

def r(lim):
    "0 <= random int < lim"
    return randint(0,lim-1)

def randname(syll):
    "random name with syll 2-letter syllables"
    v = len(vowels)
    c = len(somecons)
    res = str()
    for i in range(syll):
        res += somecons[r(c)] + vowels[r(v)]
    return res.capitalize()

# Programa principal
conn = sqlite3.connect("bigger.db")
cur = conn.cursor()

start=datetime.now()

print("Fem 10000 cerques")
for i in range(10000):
  own_name = randname(2)+' '+randname(4)
  #print(own_name)
  cur.execute("SELECT * FROM contractes WHERE owner = ?", (own_name,))
  o = cur.fetchone()
  if o:
    acc_id = o[0]
    owner_id = o[1]
    print(acc_id, owner_id)

stop = datetime.now()
print("Temps total: ", stop-start)

cur.close()
