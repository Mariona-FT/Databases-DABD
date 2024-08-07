
## Instruccions utilitzades en la sessió 12:

En aquesta sessio farem una connexió en casandra a partir de DOCKERS
```
    sudo apt-get install docker.io
    docker -v
```
Entrar en sudo per descarregar el docker de cassandra: 
```
    sudo su
    docker pull cassandra
    docker images
    docker run -d --name dabd1 -p 9042:9042 cassandra
```
```
root@mariona-laptop:/home/mariona# docker run -d --name dabd1 -p 9042:9042 cassandra
8607128f88c7137cf05ea30323996b1bdfa22eafc8b8d5762f01589db9d3e546

root@mariona-laptop:/home/mariona# docker stats
CONTAINER ID   NAME           CPU %     MEM USAGE / LIMIT     MEM %     NET I/O       BLOCK I/O        PIDS
8607128f88c7   dabd1          3.90%     4.088GiB / 15.26GiB   26.79%    4.98kB / 0B   23.5MB / 156MB   56
78d162975150   cass_cluster   3.42%     4.119GiB / 15.26GiB   26.99%    12.9kB / 0B   0B / 111MB       56

root@mariona-laptop:/home/mariona# docker ps -a
CONTAINER ID   IMAGE              COMMAND                  CREATED          STATUS          PORTS                                                                          NAMES
8607128f88c7   cassandra          "docker-entrypoint.s…"   58 seconds ago   Up 57 seconds   7000-7001/tcp, 7199/tcp, 9160/tcp, 0.0.0.0:9042->9042/tcp, :::9042->9042/tcp   dabd1
78d162975150   cassandra:latest   "docker-entrypoint.s…"   2 minutes ago    Up 2 minutes    7000-7001/tcp, 7199/tcp, 9042/tcp, 9160/tcp                                    cass_cluster
```

Per connectar-nos al servidor executarem el client CLI cqlsh (Cassandra Query Language Shell). 
(Nota: Cal esperar uns quants segons fins que el servidor estigui completament arrancat i disponible):
``   docker exec -it dabd1 cqlsh``

Per fer un script python que es connecti al servidor cassandra fer: 
`` pip install cassandra-driver``

I crear un script similar a aquest:
```
    from cassandra.cluster import Cluster

    cluster = Cluster()
    session = cluster.connect('dabd')

    rows = session.execute('SELECT * FROM usuaris')
    for user_row in rows:
        print(user_row.first_name, user_row.last_name, user_row.age, user_row.email)
```

Per fer l'script s'ha de tenir en compte que: 

No has de crear una taula de Cassandra per cada taula de l'esquema relacional. 
Recordar que a Cassandra, com a la majoria de les BD no relacionals, pots guardar valors no atòmics en els camps, per això disposa dels tipus map, list i set, amb map podem guardar un conjunt de parelles clau-valor, amb list podem guardar una llista de valors amb repeticions i amb set un conjunt de valors sense repeticions. 

Per exemple, com que la taula titular només guarda el owner_id del titular i la seva adreça, els podem guardar directament dins la taula adreces: cada adreça tindrà un set amb els titulars que viuen en aquella adreça. 

O dins la taula comptes podem guardar els titulars de cada compte, o sigui els contractes (own_id i owner).
    
taula titular: owner_id i adreça

   **ADREÇA**- guarda set de titulars d'aquella adreça
    
**COMPTES** - guarda contractes own_id i owner

 A una adreça hi viuen pocs titulars i un compte té pocs titulars, per tant seran llistes/conjunts molt petits.

A més és molt habitual les operacions de consulta de les dades d'un compte i les dades d'una adreça. 

 Així, amb una única operació de lectura i sense haver de fer joins perquè no en tenim, podem obtenir totes les dades d'un compte (tipus, saldo i titulars del compte).
 Idem amb la lectura d'una adreça i les persones que hi viuen.

El nombre de contractes d'un compte i el nombre de titulars d'una adreça han de ser aleatoris però com a mínim n'hi ha d'haver un (per exemple no té sentit un compte sense cap contracte, el compte ha de pertànyer com a mínim a una persona).
   
 Minim  compte amb 1 contracte
 Minim  adreça amb 1 titular

Cada vegada que s'executi l'script cal que elimini el KEYSPACE bank i el torni a crear de nou de forma que desprès d'executar-lo han d'haver-hi sempre 900 comptes, 500 adreces, 1000 titulars i 4000 contractes.
El mateix script NO ha de crear els índexs que siguin necessaris per evitar dades repetides (índexs únics), doncs Cassandra no disposa de UK per no fer lentes les escriptures quan s'intenta evitar duplicitats.
Només cal dissenyar les PK adequades. Algunes comprovacions per evitar repeticions les hauràs de fer a nivell de codi, per exemple per comprovar no afegir dos titulars amb el mateix owner_id en adreces diferents o en el mateix compte bancari.
 
Mirar que l'script compleixi les seguents regles: 
- incorrecte si No 900 comptes
- incorrecte si No 500 adreces
- incorrecte si No 1000 titulars
- incorrecte si No 4000 titulars
- incorrecte si account_id no es PK
- incorrecte si address o phone no es PK
- No elimina taules previes
- Titulars no dins adreces
- Contractes no dins comptes
- Contractes no són objectes
- incorrecte si Un contracte té molts titulars
- incorrecte si Núm. contr./tit. no triats aleatòriamet
- No keyspace bank
-  Num contr/lit no triats aleatoriament
- incorrecte si Afegeixes col·lecció titulars
- incorrecte si Afegeixes col·lecció contractes
- Comptes sense cap contracte
- Adreces sense cap titular
- incorrecte si  Nom owner dins adreces

 Veure si correcte en el client CQLSH: 
```
    cqlsh> USE bank;

    cqlsh:bank> SELECT * FROM comptes;
    cqlsh:bank> SELECT * FROM adreces;
```
Els fitxers seran:

Script final: [bigger.py](https://github.com/Mariona-FT/Databases-DABD/blob/main/laboratori/sessio%2012/bigger.py)

Script original no mongodb: [bigger_og.py](https://github.com/Mariona-FT/Databases-DABD/blob/main/laboratori/sessio%2012/bigger_og.py)
