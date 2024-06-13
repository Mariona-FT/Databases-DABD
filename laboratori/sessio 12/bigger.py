#!/usr/bin/env python3
# -*- coding: utf-8 -*-

from cassandra.cluster import Cluster
from random import randint, choice
from faker import Faker
fake = Faker('es_ES')

num_comptes = 900
num_adreces = 500
num_titulars = 1000
num_contractes = 4000
atypes = ('C', 'L', 'S')
vowels = ('a', 'e', 'i', 'o', 'u')
somecons = ('b', 'd', 'f', 'k', 'l', 'm', 'p', 'r', 's')

def r(lim):
    "0 <= random int < lim"
    return randint(0, lim-1)

def randname(syll):
    "random name with syll 2-letter syllables"
    v = len(vowels)
    c = len(somecons)
    res = str()
    for i in range(syll):
        res += somecons[r(c)] + vowels[r(v)]
    return res.capitalize()

def create_tables(session):
    session.execute("DROP KEYSPACE IF EXISTS bank")
    session.execute("""
    CREATE KEYSPACE bank WITH replication = {'class': 'SimpleStrategy', 'replication_factor' : 1}
    """)
    session.execute("USE bank") #bd bank
    
    session.execute("DROP TABLE IF EXISTS comptes")
    session.execute("""
    CREATE TABLE comptes(
        acc_id bigint PRIMARY KEY,
        type text,
        balance float,
        contractes set<frozen<map<int, text>>>
    )
    """)
    
    session.execute("DROP TABLE IF EXISTS adreces")
    session.execute("""
    CREATE TABLE adreces(
        address text PRIMARY KEY,
        phone text,
        titulars set<int>
    )
    """)

def create_comptes(session):
    print(f"{num_comptes} comptes will be inserted.")
    for i in range(num_comptes):
        print(i + 1, end='\r')
        acc_id = randint(100000000000, 999999999999)
        balance = randint(100, 99999) / 100
        typ = atypes[r(3)]
        contractes = set() #inicialitzar contractes BUIT
        session.execute("INSERT INTO comptes (acc_id, type, balance, contractes) VALUES (%s, %s, %s, %s)", (acc_id, typ, balance, contractes)) #inserir comptes senzill - no contractes

def create_adreces(session):
    print(f"{num_adreces} adreces will be inserted.")
    for i in range(num_adreces):
        print(i + 1, end='\r')
        address = fake.address()
        phone = fake.phone_number()
        titulars = set() #inicialitzar titulars BUIT
        session.execute("INSERT INTO adreces (address, phone, titulars) VALUES (%s, %s, %s)", (address, phone, titulars)) #inserir adreces senzill - no titulars


def create_titulars(session):
    print(f"{num_titulars} titulars will be inserted.")
    adreces = [row.address for row in session.execute("SELECT address FROM adreces")] #llista adreces 
    llista_titulars = [(randint(10000000, 99999999), address) for address in adreces] 
    titulars_restants = num_titulars - len(adreces) # titulars sobrants minim 1 per cap
    
    for _ in range(titulars_restants): 
        owner_id = randint(10000000, 99999999)
        address = choice(adreces)
        llista_titulars.append((owner_id, address)) # acabar els titulars restants - llista

    for owner_id, address in llista_titulars:
        session.execute("UPDATE adreces SET titulars = titulars + {%s} WHERE address = %s", (owner_id, address)) #inserir la llista titulars a taula adress

def create_contractes(session):
    print(f"{num_contractes} contractes will be inserted.")
    comptes = [row.acc_id for row in session.execute("SELECT acc_id FROM comptes")] # llista comptes 
    
    all_titulars = []
    adreces = session.execute("SELECT address, titulars FROM adreces") # treure de adreces la info de owner-id
    for adreca in adreces:
        titulars = adreca.titulars if adreca.titulars is not None else set()
        for owner_id in titulars:
            all_titulars.append(owner_id) #entrar per cada adreca MININM 1 titular

    # Inicialitza els comptes amb un contracte
    llista_contractes = [(choice(all_titulars), acc_id) for acc_id in comptes]
    contractes_restants = num_contractes - len(comptes) # contractes que sobren
    
    for _ in range(contractes_restants): #acabar el nombre de titulars aleatoriament per els contractes restants
        owner_id = choice(all_titulars)
        acc_id = choice(comptes)
        llista_contractes.append((owner_id, acc_id))

    for owner_id, acc_id in llista_contractes:
        owner = randname(2) + ' ' + randname(4)
        contractes_set = session.execute("SELECT contractes FROM comptes WHERE acc_id = %s", (acc_id,)).one().contractes
        contractes_set = contractes_set if contractes_set is not None else set()
        contracte = {owner_id: owner}
        session.execute("UPDATE comptes SET contractes = contractes + {%s} WHERE acc_id = %s", (contracte, acc_id)) #inserir contracte a taula compte

def main():
    cluster = Cluster(['127.0.0.1']) #localhost
    session = cluster.connect()


    create_tables(session)
    
    create_comptes(session)
    create_adreces(session)
    create_titulars(session)
    create_contractes(session)
    
    session.shutdown()
    cluster.shutdown()

if __name__ == "__main__":
    main()
