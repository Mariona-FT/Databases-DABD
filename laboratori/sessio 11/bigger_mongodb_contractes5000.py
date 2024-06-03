#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import pymongo
from random import randint
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

def create_adreces():
    print(f"{num_adreces} adreces will be inserted.")
    db.adreces.drop()
    db.adreces.create_index("address", unique=False)
    db.adreces.create_index("phone", unique=False)

    for i in range(num_adreces):
        print(i+1, end='\r')
        address = fake.address()
        phone = fake.phone_number()
        try:
            db.adreces.insert_one({"address": address, "phone": phone, "owner_ids": []})
        except pymongo.errors.DuplicateKeyError as e:
            print(f"Error inserting ({address}, {phone}). Error information: {e}")

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
        db.adreces.update_one({'address': adreca['address']}, {'$addToSet': {'owner_ids': owner_id}})
        owner_name = randname(2) + ' ' + randname(4)
        db.comptes.update_one({'acc_id': list(db.comptes.aggregate([{'$sample': {'size': 1}}]))[0]['acc_id']}, {'$addToSet': {'contractes': {'owner_id': owner_id, 'owner_name': owner_name}}})

    # Distribueix els titulars restants aleatòriament entre les adreces
    for owner_id in owner_ids_list[num_adreces:]:
        adreca = adreces_list[r(len(adreces_list))]
        owner_name = randname(2) + ' ' + randname(4)
        db.adreces.update_one({'address': adreca['address']}, {'$addToSet': {'owner_ids': owner_id}})
        db.comptes.update_one({'acc_id': list(db.comptes.aggregate([{'$sample': {'size': 1}}]))[0]['acc_id']}, {'$addToSet': {'contractes': {'owner_id': owner_id, 'owner_name': owner_name}}})

def create_contractes():
    print(f"{num_contractes} contractes will be inserted.")
    contractes_set = set()
    
    # Generar contractes únics fins arribar al nombre desitjat
    while len(contractes_set) < num_contractes:
        address_doc = None
        while not address_doc:
            address_doc = list(db.adreces.aggregate([{'$sample': {'size': 1}}]))
            if address_doc:
                address_doc = address_doc[0]

        if not address_doc['owner_ids']:
            continue

        owner_id = address_doc['owner_ids'][r(len(address_doc['owner_ids']))]
        owner_name = randname(2) + ' ' + randname(4)
        contracte = (owner_id, owner_name)
        contractes_set.add(contracte)

    comptes_cursor = db.comptes.find()
    comptes_list = list(comptes_cursor)
    if len(comptes_list) < num_contractes:
        comptes_list *= (num_contractes // len(comptes_list)) + 1
    
    contractes_list = list(contractes_set)
    
    # Assigna almenys un contracte a cada compte
    for i, compte in enumerate(comptes_list[:num_comptes]):
        owner_id, owner_name = contractes_list[i]
        db.comptes.update_one({'acc_id': compte['acc_id']}, {'$addToSet': {'contractes': {'owner_id': owner_id, 'owner_name': owner_name}}})

    # Distribueix els contractes restants aleatòriament entre els comptes
    remaining_contracts = contractes_list[num_comptes:]
    for owner_id, owner_name in remaining_contracts:
        compte = comptes_list[r(len(comptes_list))]
        db.comptes.update_one({'acc_id': compte['acc_id']}, {'$addToSet': {'contractes': {'owner_id': owner_id, 'owner_name': owner_name}}})

def count_total_contractes():
    total_contractes = db.comptes.aggregate([
        {"$unwind": "$contractes"},
        {"$count": "total_contractes"}
    ]).next()['total_contractes']
    return total_contractes

def check_rules():
    errors = []

    # No 900 comptes
    if db.comptes.count_documents({}) != 900:
        errors.append("Error: NOT exactly 900 comptes exist")

    # No 500 adreces
    if db.adreces.count_documents({}) != 500:
        errors.append("Error: NOT exactly 500 adreces exist")

    # No 1000 titulars
    owner_ids = set()
    for adreca in db.adreces.find():
        owner_ids.update(adreca['owner_ids'])
    if len(owner_ids) != 1000:
        errors.append("Error: NOT exactly 1000 titulars exist")

    # No 4000 contractes
    total_contractes = count_total_contractes()
    if total_contractes != 4000:
        errors.append(f"Error: NOT exactly 4000 contractes exist, found {total_contractes}")

    # No índex únic account_id
    if db.comptes.index_information()['acc_id_1'].get('unique'):
        errors.append("Error: account_id has a unique index")

    # No índex únic address
    if db.adreces.index_information()['address_1'].get('unique'):
        errors.append("Error: address has a unique index")

    # No índex únic phone
    if db.adreces.index_information()['phone_1'].get('unique'):
        errors.append("Error: phone has a unique index")

    # Titulars no dins adreces (verificant si s'ha afegit owner_name dins adreces)
    if db.adreces.find_one({'owner_ids.owner_name': {'$exists': True}}):
        errors.append("Error: titulars are inside adreces")

    # Contractes no dins comptes (comprovant si contractes està buit)
    if db.comptes.find_one({'contractes': {'$exists': False}}):
        errors.append("Error: contractes are not inside comptes")

    # Contractes no són objectes
    if db.comptes.find_one({'contractes.owner_id': {'$type': 'object'}}):
        errors.append("Error: contractes are objects")

    # Incorrecte si un contracte té molts titulars (assegurant que cada contracte té només un owner_id i owner_name)
    for compte in db.comptes.find():
        for contracte in compte['contractes']:
            if not isinstance(contracte, dict) or 'owner_id' not in contracte or 'owner_name' not in contracte:
                errors.append("Error: contracte structure is incorrect")
            if isinstance(contracte['owner_id'], list) or isinstance(contracte['owner_name'], list):
                errors.append("Error: contracte has many titulars")

    # Comptes sense cap contracte
    for compte in db.comptes.find():
        if not compte['contractes']:
            errors.append(f"Error: compte {compte['acc_id']} does not have any contracte")

    # Adreces sense cap titular
    for adreca in db.adreces.find():
        if not adreca['owner_ids']:
            errors.append(f"Error: adreça {adreca['address']} does not have any titular")

    # Incorrecte si Nom owner dins adreces
    if db.adreces.find_one({'owner_name': {'$exists': True}}):
        errors.append("Error: owner names are inside adreces")

    if errors:
        for error in errors:
            print(error)
    else:
        print("All rules are satisfied.")

def main():
    create_comptes()
    create_adreces()
    create_titulars()
    create_contractes()
    check_rules()

if __name__ == "__main__":
    main()
