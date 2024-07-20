## Instruccions utilitzades en la sessió 11:

1. Importar la clau pública GPG del repositori MongoDB
Obre una terminal i executa la següent ordre per importar la clau GPG:

``	wget -qO - https://www.mongodb.org/static/pgp/server-6.0.asc | sudo apt-key add -``

2. Crea el fitxer de llista del repositori
Afegeix el dipòsit MongoDB a la teva llista de fonts d'APT:

``	echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/6.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-6.0.list``

3. Actualitzeu l'índex de paquets
Actualitza la llista de paquets disponibles i les versions des dels dipòsits habilitats:
	``sudo apt update``
	
4. Instal·la MongoDB
Instal·la els paquets de MongoDB:
	``sudo apt install -i mongodb-org``

5. Inicia i habilita el servei de MongoDB
Inicia el servei MongoDB:
	``sudo systemctl start mongod``
	
Habilita el servei perquè s'iniciï automàticament a l'arrencada del sistema:
	``sudo systemctl enable mongod``

6. Verifica la instal·lació
Verifica que MongoDB estigui funcionant correctament:
	``sudo systemctl status mongod``

```
mariona@mariona-laptop:~$ sudo systemctl status mongod
● mongod.service - MongoDB Database Server
     Loaded: loaded (/lib/systemd/system/mongod.service; enabled; vendor preset: enabled)
     Active: active (running) since Mon 2024-05-27 13:08:49 CEST; 19s ago
       Docs: https://docs.mongodb.org/manual
   Main PID: 5635 (mongod)
     Memory: 68.9M
        CPU: 449ms
     CGroup: /system.slice/mongod.service
             └─5635 /usr/bin/mongod --config /etc/mongod.conf

may 27 13:08:49 mariona-laptop systemd[1]: Started MongoDB Database Server.
may 27 13:08:49 mariona-laptop mongod[5635]: {"t":{"$date":"2024-05-27T11:08:49.152Z"},"s":"I",  "c":"CONTROL",  "id":7484500,>
```

7. Accedeix a l'intèrpret d'ordres de MongoDB
Per accedir a la consola de MongoDB, podeu executar:
``	mongosh``

Seguint aquests passos, hauríeu de poder instal·lar MongoDB a Ubuntu 22.04 sense problemes de dependències.

2) Connecta't amb el client de línies de comanda (mongo). Crea una base de dades (dabd) amb dues col·leccions (alumne i professor) on inserirem diferents documents. També practiquem les cerques, actualitzacions i eliminacions de documents.

```
test> use dabd
switched to db dabd
dabd> show dbs
admin   40.00 KiB
config  12.00 KiB
local   40.00 KiB
dabd> db.createCollection('alumne')
{ ok: 1 }
dabd> show dbs
admin   40.00 KiB
config  60.00 KiB
dabd     8.00 KiB
local   40.00 KiB
dabd> show collections
alumne
```
Crear col·lecció d'alumne i inserir i buscar alumnes:
```
dabd> db.alumne.insert({'nom': 'Oriol', 'c1': 7, 'observacions': 'Treballa'})
DeprecationWarning: Collection.insert() is deprecated. Use insertOne, insertMany, or bulkWrite.
{
  acknowledged: true,
  insertedIds: { '0': ObjectId('66546bb19595424341a26a13') }
}
dabd> db.alumne.insert({'nom': 'Pau', 'c1': 4})
{
  acknowledged: true,
  insertedIds: { '0': ObjectId('66546bb19595424341a26a14') }
}
dabd> db.alumne.insert({'nom': 'Paula', 'c1': 6})
{
  acknowledged: true,
  insertedIds: { '0': ObjectId('66546bb19595424341a26a15') }
}
dabd> db.alumne.insert({'nom': 'Pol', 'c1': 6})
{
  acknowledged: true,
  insertedIds: { '0': ObjectId('66546bb19595424341a26a16') }
}
dabd> db.alumne.insert({'nom': 'Pau', 'c1': 6})
{
  acknowledged: true,
  insertedIds: { '0': ObjectId('66546bb19595424341a26a17') }
}
```
```
dabd> db.alumne.find()
[
  {
    _id: ObjectId('66546bb19595424341a26a13'),
    nom: 'Oriol',
    c1: 7,
    observacions: 'Treballa'
  },
  { _id: ObjectId('66546bb19595424341a26a14'), nom: 'Pau', c1: 4 },
  { _id: ObjectId('66546bb19595424341a26a15'), nom: 'Paula', c1: 6 },
  { _id: ObjectId('66546bb19595424341a26a16'), nom: 'Pol', c1: 6 },
  { _id: ObjectId('66546bb19595424341a26a17'), nom: 'Pau', c1: 6 }
]
dabd> db.alumne.find({'nom': 'Pau'})
[
  { _id: ObjectId('66546bb19595424341a26a14'), nom: 'Pau', c1: 4 },
  { _id: ObjectId('66546bb19595424341a26a17'), nom: 'Pau', c1: 6 }
]
dabd> db.alumne.find({'nom': /Pa/})
[
  { _id: ObjectId('66546bb19595424341a26a14'), nom: 'Pau', c1: 4 },
  { _id: ObjectId('66546bb19595424341a26a15'), nom: 'Paula', c1: 6 },
  { _id: ObjectId('66546bb19595424341a26a17'), nom: 'Pau', c1: 6 }
]
dabd> db.alumne.find({'nom': /pa/})

dabd> db.alumne.find({'nom': /pa/i})
[
  { _id: ObjectId('66546bb19595424341a26a14'), nom: 'Pau', c1: 4 },
  { _id: ObjectId('66546bb19595424341a26a15'), nom: 'Paula', c1: 6 },
  { _id: ObjectId('66546bb19595424341a26a17'), nom: 'Pau', c1: 6 }
]
dabd> db.alumne.find({'c1': {$gt: 5}})
[
  {
    _id: ObjectId('66546bb19595424341a26a13'),
    nom: 'Oriol',
    c1: 7,
    observacions: 'Treballa'
  },
  { _id: ObjectId('66546bb19595424341a26a15'), nom: 'Paula', c1: 6 },
  { _id: ObjectId('66546bb19595424341a26a16'), nom: 'Pol', c1: 6 },
  { _id: ObjectId('66546bb19595424341a26a17'), nom: 'Pau', c1: 6 }
]
dabd> db.alumne.find({'c1': {$gt: 5}}, {'nom': 1})
[
  { _id: ObjectId('66546bb19595424341a26a13'), nom: 'Oriol' },
  { _id: ObjectId('66546bb19595424341a26a15'), nom: 'Paula' },
  { _id: ObjectId('66546bb19595424341a26a16'), nom: 'Pol' },
  { _id: ObjectId('66546bb19595424341a26a17'), nom: 'Pau' }
]
```
Crear un index pels diferents texts per fer les cerques més eficients: 
```
dabd> db.alumne.createIndex({nom: "text"})
nom_text
dabd> db.alumne.find({$text: {$search: "Pol"}})
[ { _id: ObjectId('66546bb19595424341a26a16'), nom: 'Pol', c1: 6 } ]
```
Crear 2ona col·lecció de professors i inserir, modificar i eliminar: 
```
dabd> db.professor.insert({'nom': 'Balqui', 'afició': 'Música'})
{
  acknowledged: true,
  insertedIds: { '0': ObjectId('66546c729595424341a26a18') }
}
dabd> show collections
alumne
professor
dabd> db.professor.insert({'nom': 'Jordi', 'afició': 'DIY', 'assignatures': ['DABD', 'PMUD', 'INFO']})
{
  acknowledged: true,
  insertedIds: { '0': ObjectId('66546c729595424341a26a19') }
}
dabd> db.professor.update({'nom': {$eq: 'Balqui'}}, {$set: {'assignatures': ['DABD']}})
DeprecationWarning: Collection.update() is deprecated. Use updateOne, updateMany, or bulkWrite.
{
  acknowledged: true,
  insertedId: null,
  matchedCount: 1,
  modifiedCount: 1,
  upsertedCount: 0
}
dabd> db.professor.find({'nom': {$eq: 'Balqui'}})
[
  {
    _id: ObjectId('66546c729595424341a26a18'),
    nom: 'Balqui',
    'afició': 'Música',
    assignatures: [ 'DABD' ]
  }
]
dabd> db.professor.remove({'nom': {$eq: 'Jordi'}})
DeprecationWarning: Collection.remove() is deprecated. Use deleteOne, deleteMany, findOneAndDelete, or bulkWrite.
{ acknowledged: true, deletedCount: 1 }
```
Per eliminar la base de dades seria: 
``db.dropDatabase()``

Mapeig de tots els registres entre parella clau-valor per obtenir l'agregació dins d'una nova col·lecció.
Els estudiants que començin per PA s'agrupin pel seu nom.
Per mirar la nova col·lecció de nota mitja cal mirar en un .find() al final 
```
dabd> db.alumne.mapReduce(
...    function() {emit(this.nom, this.c1);},  //map function
...    function(key, values) {return Array.avg(values)}, { //reduce function
...       out: "nota_mitja",
...       query: {nom: /pa/i},
...    }
... )
DeprecationWarning: Collection.mapReduce() is deprecated. Use an aggregation instead.
See https://docs.mongodb.com/manual/core/map-reduce for details.
{ result: 'nota_mitja', ok: 1 }
```
Altre manera de agregació de dades es: Aggregation Pipelines:
```
dabd> db.alumne.aggregate([
...     {$match: {nom: /pa/i}},
...     {$group: {_id: "$nom", nota_mitja: {$avg: "$c1"}}}
... ])
[ { _id: 'Pau', nota_mitja: 5 }, { _id: 'Paula', nota_mitja: 6 } ]
```
3) Instal·la't un client amb GUI de mongoDB, per exemple MongoDB Compass (Community Edition). Connecta't al servidor i mira't i gestiona els continguts de la base de dades dabd. 
Ves a una de les col·leccions de la base de dades dabd i mira't les diferents pestanyes que ofereix:

  Documents: Consulta dels documents en vista llista o taula

  Aggregations: On podem crear i gestionar Aggregation Pipelines. Crea un com el que hem definit abans amb la comanda aggregate().

  Explain Plan: Per avaluar el rendiment de les consultes (prova diferents filtres, a veure quin pot aprofitar algun índex)

  Indexes: Gestió dels índexs de la col·leció, observa que per defecte sempre en tenen un basat en el camp _id

  Trobar en la web oficial del mongoDB Compass:  https://www.mongodb.com/try/download/compass 
  descarregar el fitxer .deb del sistema operatiu que s'esta utilitzant despres desempaquetar amb:  ``sudo dpkg -i mongodb-compass_1.43.0_amd64.deb``
  ara es podrà entrar en l'aplicació executant: 
``mariona@mariona-laptop:~$ mongodb-compass``
  O des de la icona de l'aplicació Mongodb

  Una vegada descarregat, podrem veure les diferents bases de dades del mongodb que hi han en el sistema, en aquest cas hi hauran:
- admin , config, dabd, local

i a dins de dabd podrem veure les diferents col·leccions:
- alumne, nota_mitja, professor 


4) Instal·lat la llibreria Python de mongoDB:
``pip3 install pymongo``

Mira el codi del programa Python [users_mongodb.py](https://github.com/Mariona-FT/Databases-DABD/blob/main/laboratori/sessio%2011/users_mongodb.py) i executa'l varies vegades per:

Agafar el codi de Ubiwan! 
```
:/home/public/dabd/11mongodb$ ls
users_mongodb.py
userubi@ubiwan:/home/public/dabd/11mongodb$ cp -r users_mongodb.py /home/est/userubi/DABD
```
- Opció -i: Crea una base de dades i una col·lecció
- Opció -a: Afegeix nous usuaris i contrasenyes
- Opció -l: Llista tots els usuaris i contrasenyes
- Opció -d: Elimina un usuari
- Sense cap opció: Mira si existeix un usuari i contrasenya en concret
- El codi permet fer SQL injection o alguna cosa similar? En cas afirmatiu, què caldria fer per evitar-ho?

```
/laboratori/sessio 11$ python3 users_mongodb.py -i
Creating users collection

laboratori/sessio 11$ python3 users_mongodb.py -a
Adding further users, leave empty username to finish
username: carlota
passwd: bonica
InsertOneResult(ObjectId('665da161ad6021fee4579ec0'), acknowledged=True)
username: pomma
passwd: 123   
InsertOneResult(ObjectId('665da16dad6021fee4579ec1'), acknowledged=True)
username: rata
passwd: 321
InsertOneResult(ObjectId('665da174ad6021fee4579ec2'), acknowledged=True)
username: 
/laboratori/sessio 11$ python3 users_mongodb.py -l
Listing full users collection:
_id :  665da161ad6021fee4579ec0
username :  carlota
passwd :  bonica
_id :  665da16dad6021fee4579ec1
username :  pomma
passwd :  123
_id :  665da174ad6021fee4579ec2
username :  rata
passwd :  321
/sessio 11$ python3 users_mongodb.py 
Checking some user
username:carlota
passwd:bonica
Access granted to user: carlota via passwd: bonica
/laboratori/sessio 11$ python3 users_mongodb.py -d
Deleting an user
username: rata
User rata deleted.
```

5) Feina a fer

Cal adaptar l'script bigger.py de la Sessió 7. Índexs que crea 900 comptes, 500 adreces, 1000 titulars i 4000 contractes per fer-ho en una base de dades mongoDB anomenada bank. L'has de pujar a la tasca d'aquesta sessió. 

Consells:
Aprèn a usar la llibreria pymongo en poc temps a partir d'exemples. Mira't el codi de l'script users_mongodb.py i exemples de codi en recursos a la web:
  Tutorial de pymongo
  Exemples de tasques específiques de pymongo

No has de crear una col·lecció de mongoDB per cada taula de l'esquema relacional. Recordar que a mongoDB, com a la majoria de les BD no relacionals, pots guardar valors no atòmics en els camps, com els subdocuments i els arrays que permeten guardar un document o llistes de dades dins d'un camp respectivament. 
Per exemple, com que la taula titular només guarda el owner_id del titular i la seva adreça
, els podem guardar directament dins la col·lecció adreces: cada adreça tindrà un array amb els titulars que viuen en aquella adreça. O dins la col·lecció comptes podem guardar els titulars de cada compte, o sigui els contractes (own_id i owner). 
titular:ownerid i adreça
- adreces -> cada adreca tindra un array amb els titulars que viuen en aquella adreça
comptes podem guardar els titulars de cada compte
- comptes-> own_id i owner
tenint només les coleccions: ADRECES I COMPTES

 **COMPTES {dif CONTACTES }
  ADRECES {dif TITULARS }**

A una adreça hi viuen pocs titulars i un compte té pocs titulars, per tant seran arrays molt petits. A més és molt habitual les operacions de consulta de les dades d'un compte i les dades d'una adreça. 

Així, amb una única operació de lectura i sense haver de fer joins perquè no en tenim, podem obtenir totes les dades d'un compte (tipus, saldo i titulars del compte). Idem amb la lectura d'una adreça i les persones que hi viuen.

El nombre de contractes d'un compte i el nombre de titulars d'una adreça han de ser aleatoris però com a mínim n'hi ha d'haver un (per exemple no té sentit un compte sense cap contracte, el compte ha de pertànyer com a mínim a una persona).

Minim un contacter d'un compte i una adreça minim un titular

Cada vegada que s'executi l'script cal que elimini els documents de totes les col·leccions, de forma que desprès d'executar-lo han d'haver-hi sempre 900 comptes, 500 adreces, 1000 titulars i 4000 contractes.

El mateix script ha de crear els índexs que siguin necessaris per accelerar els accessos a les col·leccions o per evitar dades repetides (índexs únics). Mira la documentació de com crear índexs des de pymong. Algunes comprovacions per evitar repeticions les hauràs de fer a nivell de codi, per exemple per comprovar no afegir dos titulars amb el mateix owner_id en adreces diferents o en el mateix compte bancari.

Com hem dit, els titulars els guardem com arrays dins de la col·lecció adreces, suposem que aquest camp es diu 'titulars'. Per comprovar si un titular està dins d'un adreça, hem de cercar que algun element de l'array 'titulars' de la col·lecció adreces coincideixi amb el titular. Ho podem fer usant l'operador 
```
$elemMatch:
    res = db.adreces.find_one({'titulars': {'$elemMatch': {'$eq': owner_id}}})
```
Per obtenir un document aleatori pots usar l'operador $sample de les agregacions de mongoDB. Per exemple per obtenir una adreça aleatòria de la col·lecció de 500 adreces:
```
    adreces = list(db.adreces.aggregate([{'$sample': {'size': 1}}]))
```

Mirar que l'script compleixi les seguents regles: 
-  No 900 comptes
-  No 500 adreces
- No 1000 titulars
- No 4000 titulars

- No índex únic account_id
- No índex únic address
-  No índex únic phone

- Titulars no dins adreces

- Contractes no dins comptes
-  Contractes no són objectes

- incorrecte si Un contracte té molts titulars
- incorrecte si Núm. contr./tit. no triats aleatòriamet

- incorrecte si Afegeixes col·lecció titulars
- incorrecte si Afegeixes col·lecció contractes

- Comptes sense cap contracte
- Adreces sense cap titular
  
- incorrecte si  Nom owner dins adreces

 Ens hem de quedar amb 2 coleccions:

 - **comptes**: acc_id, type, balance, contractes: arrays d'objectes contracte

- **adreces**: id, address, phone , titulars : nomes el ID

Els fitxers seran: 

Script final: [bigger.py](https://github.com/Mariona-FT/Databases-DABD/blob/main/laboratori/sessio%2011/bigger.py)

Script amb proves: [bigger_tests.py](https://github.com/Mariona-FT/Databases-DABD/blob/main/laboratori/sessio%2011/bigger_tests.py)

Script original no mongodb: [bigger_og.py](https://github.com/Mariona-FT/Databases-DABD/blob/main/laboratori/sessio%2011/bigger_og.py)
