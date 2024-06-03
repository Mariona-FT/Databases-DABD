#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import pymongo
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

client = pymongo.MongoClient("mongodb://localhost:27017/")
db = client['bank']

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

def create_comptes():
    print(f"{num_comptes} comptes will be inserted.")
    db.comptes.drop()
    db.comptes.create_index("acc_id", unique=True)

    for i in range(num_comptes):
        print(i+1, end='\r')
        acc_id = randint(100000000000, 999999999999)
        balance = randint(100, 99999) / 100
        typ = atypes[r(3)]
        try:
            db.comptes.insert_one({"acc_id": acc_id, "type": typ, "balance": balance, "contractes": []})
        except pymongo.errors.DuplicateKeyError as e:
            print(f"Error inserting ({acc_id}, {typ}, {balance}). Error information: {e}")

#adreces
def create_adreces():
    print(f"{num_adreces} adreces will be inserted.")
    db.adreces.drop()
    db.adreces.create_index("address", unique=True)
    db.adreces.create_index("phone", unique=True)

    for i in range(num_adreces):
        print(i+1, end='\r')
        address = fake.address()
        phone = fake.phone_number()
        try:
            db.adreces.insert_one({"address": address, "phone": phone, "titulars": []})
        except pymongo.errors.DuplicateKeyError as e:
            print(f"Error inserting ({address}, {phone}). Error information: {e}")

#titulars dins de adreces 
def create_titulars():
    print(f"{num_titulars} titulars will be inserted.")
    owner_ids_set = set()
    while len(owner_ids_set) < num_titulars:
        owner_id = randint(10000000, 99999999)
        if owner_id not in owner_ids_set:
            owner_ids_set.add(owner_id)

    adreces_cursor = db.adreces.find()
    adreces_list = list(adreces_cursor)
    if len(adreces_list) < num_titulars:
        adreces_list *= (num_titulars // len(adreces_list)) + 1
    
    owner_ids_list = list(owner_ids_set)
    
    # Assigna almenys un titular a cada adreça
    for i, adreca in enumerate(adreces_list[:num_adreces]):
        owner_id = owner_ids_list[i]
        owner_name = randname(2) + ' ' + randname(4)
        db.adreces.update_one({'address': adreca['address']}, {'$addToSet': {'titulars': {'owner_id': owner_id, 'owner': owner_name}}})

    # Distribueix els titulars restants aleatòriament entre les adreces
    for owner_id in owner_ids_list[num_adreces:]:
        adreca = adreces_list[r(len(adreces_list))]
        owner_name = randname(2) + ' ' + randname(4)
        db.adreces.update_one({'address': adreca['address']}, {'$addToSet': {'titulars': {'owner_id': owner_id, 'owner': owner_name}}})

# 900 contractes inicials als comptes
def create_initial_contractes():
    print(f"{num_comptes} initial  9000 comptes will be inserted one contractes .")
    comptes = list(db.comptes.find())
    for compte in comptes:
        address_with_titulars = list(db.adreces.aggregate([
            {'$match': {'titulars.0': {'$exists': True}}},
            {'$sample': {'size': 1}}
        ]))[0]
        titular = choice(address_with_titulars['titulars'])
        owner_id = titular['owner_id']
        owner = titular['owner']
        db.comptes.update_one({'acc_id': compte['acc_id']}, {'$push': {'contractes': {'owner_id': owner_id, 'owner': owner}}})

##3100 contractes addicionals - a repartir
def create_additional_contractes():
    print(f"{num_contractes - num_comptes} additional contractes will be inserted randomly in comptes.")
    existent_contractes = set()
    for i in range(num_contractes - num_comptes):
        print(i + 1, end='\r')
        acc_id = list(db.comptes.aggregate([{'$sample': {'size': 1}}]))[0]['acc_id']
        address_with_titulars = list(db.adreces.aggregate([
            {'$match': {'titulars.0': {'$exists': True}}},
            {'$sample': {'size': 1}}
        ]))[0]
        titular = choice(address_with_titulars['titulars'])
        owner_id = titular['owner_id']
        owner = titular['owner']

        while (acc_id, owner_id) in existent_contractes:
            address_with_titulars = list(db.adreces.aggregate([
                {'$match': {'titulars.0': {'$exists': True}}},
                {'$sample': {'size': 1}}
            ]))[0]
            titular = choice(address_with_titulars['titulars'])
            owner_id = titular['owner_id']
            owner = titular['owner']

        existent_contractes.add((acc_id, owner_id))
        db.comptes.update_one({'acc_id': acc_id}, {'$push': {'contractes': {'owner_id': owner_id, 'owner': owner}}})

    
def main():
    create_comptes()
    create_adreces()
    create_titulars()
    create_initial_contractes()
    create_additional_contractes()

if __name__ == "__main__":
    main()
