## Instruccions utilitzades en la sessió 7:

descarregar les seguents carpetes en ubiwan: dins de ubiwan!
```
$ cd /home/public/dabd/
cu@ubiwan:/home/public/dabd$ cp -r 07/ /home/est/userubi/DABD/sessio7
```
Copiar en una carpeta local.

1) Executa l'script bigger.py per crear la base de dades bigger.db que conté 4 taules (comptes, adreces, titulars, contractes) amb molts registres.

Executar el script [bigger.py](https://github.com/Mariona-FT/Databases-DABD/blob/main/laboratori/sessio%207/bigger.py):
```
mariona@mariona-laptop:~/Documentos/altres-DABD/sessio7/sessio7$ python3 bigger.py 
900 comptes will be inserted.
500 adreces will be inserted.
1000 titulars will be inserted.
4000 contractes will be inserted.
```
On es crearà un fitxer de base de dades: [bigger.bd](https://github.com/Mariona-FT/Databases-DABD/blob/main/laboratori/sessio%207/bigger.db)

2) Obre la base de dades bigger.db amb el client de terminal sqlite3 i executa aquestes comandes (la comanda pragma index_list(taula) permet consultar els índexs que hi ha associats a la taula):

Entrar amb sqlite3:
```
mariona@mariona-laptop:~/Documentos/altres-DABD/sessio7/sessio7$ sqlite3 bigger.db 
SQLite version 3.37.2 2022-01-06 13:25:41
Enter ".help" for usage hints.
```
Veure les taules creades amb el seu schema:
```
sqlite> .schema
CREATE TABLE comptes(
    acc_id bigint NOT NULL PRIMARY KEY,
    type char(1) NOT NULL,
    balance float NOT NULL
  );
CREATE TABLE adreces(
    address varchar(100) NOT NULL PRIMARY KEY,
    phone varchar(20) DEFAULT NULL UNIQUE
  );
CREATE TABLE titulars(
    owner_id int NOT NULL PRIMARY KEY,
    address varchar(100) NOT NULL REFERENCES adreces ON UPDATE CASCADE
  );
CREATE TABLE contractes(
    acc_id bigint NOT NULL REFERENCES comptes ON UPDATE CASCADE,
    owner_id int NOT NULL REFERENCES titulars ON UPDATE CASCADE,
    owner varchar(40) NOT NULL,
    PRIMARY KEY(acc_id, owner_id)
  );
```
Activar els headers:``sqlite> .headers on``

Veure els esquemes de les taules per ceure els índex associats aquestes taules:
```
sqlite> pragma INDEX_List(comptes);
seq|name|unique|origin|partial
0|sqlite_autoindex_comptes_1|1|pk|0

sqlite> pragma INDEX_List(adreces);
seq|name|unique|origin|partial
0|sqlite_autoindex_adreces_2|1|u|0
1|sqlite_autoindex_adreces_1|1|pk|0
//Te 2INDEXOS - té PK i UNIQUE

sqlite> pragma INDEX_List(titulars);
seq|name|unique|origin|partial
0|sqlite_autoindex_titulars_1|1|pk|0

sqlite> pragma INDEX_List(contractes);
seq|name|unique|origin|partial
0|sqlite_autoindex_contractes_1|1|pk|0
```
Taules de informació del sistema:

_Sqlite_master_: definició de taules i índex de les bd, amb ROOTPAGE-> on es troba situat l'arrel de l'arbre B-tree corresponent

```
sqlite> SELECT * FROM sqlite_master;
type|name|tbl_name|rootpage|sql
table|comptes|comptes|2|CREATE TABLE comptes(
    acc_id bigint NOT NULL PRIMARY KEY,
    type char(1) NOT NULL,
    balance float NOT NULL
  )
index|sqlite_autoindex_comptes_1|comptes|3|
table|adreces|adreces|14|CREATE TABLE adreces(
    address varchar(100) NOT NULL PRIMARY KEY,
    phone varchar(20) DEFAULT NULL UNIQUE
  )
index|sqlite_autoindex_adreces_1|adreces|15|
index|sqlite_autoindex_adreces_2|adreces|16|
table|titulars|titulars|37|CREATE TABLE titulars(
    owner_id int NOT NULL PRIMARY KEY,
    address varchar(100) NOT NULL REFERENCES adreces ON UPDATE CASCADE
  )
index|sqlite_autoindex_titulars_1|titulars|38|
table|contractes|contractes|57|CREATE TABLE contractes(
    acc_id bigint NOT NULL REFERENCES comptes ON UPDATE CASCADE,
    owner_id int NOT NULL REFERENCES titulars ON UPDATE CASCADE,
    owner varchar(40) NOT NULL,
    PRIMARY KEY(acc_id, owner_id)
  )
index|sqlite_autoindex_contractes_1|contractes|58|
```

_sqlite_stat1_:Estadístiques de cadacun dels índex, nombre del registre total i el nombre de registres mitja que obtindriem al usar aquest índex:
```
sqlite> ANALYZE;
sqlite> SELECT * FROM sqlite_stat1;
tbl|idx|stat
contractes|sqlite_autoindex_contractes_1|4000 5 1
titulars|sqlite_autoindex_titulars_1|1000 1
adreces|sqlite_autoindex_adreces_2|500 1
adreces|sqlite_autoindex_adreces_1|500 1
comptes|sqlite_autoindex_comptes_1|900 1
```

STAT: Es pot veure el número de les :
- si és 1: qualsevol d'aquest index en una cerca obtindriem un únic resultat (PK o UNIQUES que no accepten repecticions: titulars hi han 1000 índex que son ÚNICS)

- si es diferent: Exempre contractes: 5 1 :  en una cerca seqüencial hauríem de visitar 4000 registres fent una cerca amb l'índex trobaríem de mitjana 5 registres amb el mateix acc_id 1 registre amb el mateix acc_id+owner_id


3) Anem a observar l'efecte d'afegir un índex addicional.

Executar el script de consultes:
```
mariona@mariona-laptop:~/Documentos/altres-DABD/sessio7/sessio7$ python3 consulta_bigger.py 
Fem 10000 cerques
Temps total:  0:00:01.209025
```

On triga més de 1segon en fer les cerques.

El que es pot fer es **CREAR UN ÍNDEX EN SQLITE**
```
Mariona@mariona-laptop:~/Documentos/altres-DABD/sessio7/sessio7$ sqlite3 bigger.db 
SQLite version 3.37.2 2022-01-06 13:25:41
sqlite> CREATE INDEX idx_contractes_owner ON contractes(owner);
sqlite> .quit
```
Ara si ho tornem a executar:
```
mariona@mariona-laptop:~/Documentos/altres-DABD/sessio7/sessio7$ python3 consulta_bigger.py 
Fem 10000 cerques
Temps total:  0:00:00.149168
```
Només haura trigat uns 0.2 segons

4) Adapta els scripts bigger.py i consulta_bigger.py per crear i consultar la base de dades en un SGBD MySQL i repeteix el passos anteriors connectant-te al MySQL del servidor ubiwan.epsevg.upc.edu.

Des de UBIWAN executar els codis!!
(no trigara molt temps de delay entre el servidor i mysql no sigui massa)

instal·lar paquets en ubiwan:
```
:~/DABD/sessio7$ pip install faker
:~/DABD/sessio7$ pip install mysql-connector-python
```
Fer unes còpies dels scripts: 

    - bigger.py --> bigger-mysql.py
    - consulta_bigger.py -->  consulta_bigger-mysql.py 

Els fitxers resultats serien: [bigger-mysql.py](https://github.com/Mariona-FT/Databases-DABD/blob/main/laboratori/sessio%207/bigger-mysql.py) i [consulta_bigger-mysql.py ](https://github.com/Mariona-FT/Databases-DABD/blob/main/laboratori/sessio%207/consulta_bigger-mysql.py)

- En [bigger-mysql.py](https://github.com/Mariona-FT/Databases-DABD/blob/main/laboratori/sessio%207/bigger-mysql.py): 
Canviar per teninr connexio a la bd de mysql: 
```
import mysql.connector
...
# Programa principal
#conn = sqlite3.connect("bigger.db")
# Connexió a la base de dades MySQL
conn = mysql.connector.connect(
    host="ubiwan.epsevg.upc.edu",
    user="..",
    password="..",
    database=".."
)
cur = conn.cursor()
```
I canviant tot els RANDOM() per RAND()

Executar en ubiwan:
```
~/DABD/sessio7$ python3 bigger-mysql.py 
900 comptes will be inserted.
500 adreces will be inserted.
1000 titulars will be inserted.
4000 contractes will be inserted
```
I en MYSQL es pot veure les taules creades: 
```
mysql> show tables;
+------------------------+
| Tables_in_est_ubiwanub |
+------------------------+
| accounts               |
| adreces                | *
| comptes                | *
| contractes             | *
| movies                 |
| pets                   |
| titulars               | *
| users                  |
| view_average           |
| view_gossos            |
+------------------------+
10 rows in set (0.00 sec)
```
- En [consulta_bigger-mysql.py ](https://github.com/Mariona-FT/Databases-DABD/blob/main/laboratori/sessio%207/consulta_bigger-mysql.py):
Canviar per teninr connexio a la bd de mysql: 
```
import mysql.connector
...
# Programa principal
#conn = sqlite3.connect("bigger.db")
# Connexió a la base de dades MySQL
conn = mysql.connector.connect(
    host="ubiwan.epsevg.upc.edu",
    user="..",
    password="..",
    database=".."
)
cur = conn.cursor()
```
Canviar aquesta línea posant %s: 
```
...
  cur.execute("SELECT * FROM contractes WHERE owner = %s", (own_name,))
...
```
Excutar en ubiwan:
```
~/DABD/sessio7$ python3 consulta_bigger-mysql.py 
Fem 10000 cerques
Temps total:  0:00:11.042920
```
4.b) Primer prova de fer 10.000 consultes amb i sense índex en la columna owner de la taula contractes, havent creat 90 comptes, 50 adreces, 100 titulars i 400 contractes. Observa si val la pena haver creat l'índex.

Els fitxers utilitzats serien: [bigger-mysql.py](https://github.com/Mariona-FT/Databases-DABD/blob/main/laboratori/sessio%207/bigger-mysql.py) i [consulta_bigger-mysql.py ](https://github.com/Mariona-FT/Databases-DABD/blob/main/laboratori/sessio%207/consulta_bigger-mysql.py)
```
~/DABD/sessio7$ python3 bigger-mysql.py 
90 comptes will be inserted.
50 adreces will be inserted.
100 titulars will be inserted.
400 contractes will be inserted.
```
Abans de crear index:
```
~/DABD/sessio7$ python3 consulta_bigger-mysql.py 
Fem 10000 cerques
Temps total:  0:00:02.317044
```

**Crear índex:**
```
mysql> CREATE INDEX idx_contractes_owner ON contractes(owner);
Query OK, 0 rows affected (0.09 sec)
Records: 0  Duplicates: 0  Warnings: 0
```
Despres crear index:
```
~/DABD/sessio7$ python3 consulta_bigger-mysql.py 
Fem 10000 cerques
Temps total:  0:00:01.783569
```
Borrar index:
```
DROP INDEX idx_contractes_owner ON contractes;
```

4.c) Desprès prova de fer 10.000 consultes amb i sense índex en la columna owner de la taula contractes, havent creat 900 comptes, 500 adreces, 1000 titulars i 4000 contractes. Observa si val la pena haver creat l'índex.

Els fitxers utilitzats serien: [bigger-mysql.py](https://github.com/Mariona-FT/Databases-DABD/blob/main/laboratori/sessio%207/bigger-mysql.py) i [consulta_bigger-mysql.py ](https://github.com/Mariona-FT/Databases-DABD/blob/main/laboratori/sessio%207/consulta_bigger-mysql.py)

Abans de crear index:
```
~/DABD/sessio7$ python3 consulta_bigger-mysql.py 
Fem 10000 cerques
Temps total:  0:00:11.042920
```
**Crear índex:**
```
mysql> CREATE INDEX idx_contractes_owner ON contractes (owner);
Query OK, 0 rows affected (0.15 sec)
Records: 0  Duplicates: 0  Warnings: 0
```
Despres de crear index:
```
~/DABD/sessio7$ python3 consulta_bigger-mysql.py 
Fem 10000 cerques
Temps total:  0:00:01.695835
```
Redueix 10 segons en fer 10000 consultes utilitzant un index !

Per consultar els índexs creats d'una taula pots usar: SHOW INDEX FROM taula;
```
mysql> SHOW INDEX FROM contractes;
+------------+------------+----------------------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+---------+------------+
| Table      | Non_unique | Key_name             | Seq_in_index | Column_name | Collation | Cardinality | Sub_part | Packed | Null | Index_type | Comment | Index_comment | Visible | Expression |
+------------+------------+----------------------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+---------+------------+
| contractes |          0 | PRIMARY              |            1 | acc_id      | A         |         886 |     NULL |   NULL |      | BTREE      |         |               | YES     | NULL       |
| contractes |          0 | PRIMARY              |            2 | owner_id    | A         |        4000 |     NULL |   NULL |      | BTREE      |         |               | YES     | NULL       |
| contractes |          1 | idx_contractes_owner |            1 | owner       | A         |        4000 |     NULL |   NULL |      | BTREE      |         |               | YES     | NULL       |
+------------+------------+----------------------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+---------+------------+
3 rows in set (0.02 sec)
```

5) Adapta els scripts bigger.py i consulta_bigger.py per crear i consultar la base de dades en un SGBD PostgreSQL i repeteix el passos anteriors connectant-te al PostgreSQL del servidor ubiwan.epsevg.upc.edu.

Des de UBIWAN executar els codis!!
(no trigara molt temps de delay entre el servidor i mysql no sigui massa)

Fer unes còpies dels scripts: 

- bigger.py --> bigger-postrge.py
- consulta_bigger.py -->  consulta_bigger-postgre.py 

Els fitxers resultats serien: [bigger-postgre.py](https://github.com/Mariona-FT/Databases-DABD/blob/main/laboratori/sessio%207/bigger-postgre.py) i [consulta_bigger-postge.py](https://github.com/Mariona-FT/Databases-DABD/blob/main/laboratori/sessio%207/consulta_bigger-postge.py)

- En bigger-postgre.py
``~/DABD/sessio7$ pip install psycopg2-binary;``

- En consulta_bigger-postgre.py
```
import psycopg2

# Connexió a la base de dades MySQL
conn = psycopg2.connect(
    host="ubiwan.epsevg.upc.edu",
    user="..",
    password="..",
    database=".."
)
cur = conn.cursor()
...
```
Mirar en postge:
```
=> \dt
                             List of relations
 Schema |                    Name                    | Type  |    Owner     
--------+--------------------------------------------+-------+--------------
 public | accounts                                   | table | 
 public | adreces                                    | table | *
 public | auth_group                                 | table | 
 public | auth_group_permissions                     | table | 
 public | auth_permission                            | table | 
 public | auth_user                                  | table | 
 public | auth_user_groups                           | table | 
 public | auth_user_user_permissions                 | table | 
 public | comptes                                    | table | *
 public | contractes                                 | table | *
 public | django_admin_log                           | table | 
 public | django_content_type                        | table | 
 public | django_migrations                          | table | 
 public | django_session                             | table | 
 public | movies                                     | table | 
 public | pets                                       | table | 
 public | producte_productcategory                   | table | 
 public | producte_productcategory_product_templates | table | 
 public | producte_producttemplate                   | table | 
 public | producte_productvariant                    | table | 
 public | titulars                                   | table | *
 public | users                                      | table | 
(22 rows)
```

5.b) Primer prova de fer 10.000 consultes sense índex, amb un índex btree i amb un índex hash en la columna owner de la taula contractes, havent creat 90 comptes, 50 adreces, 100 titulars i 400 contractes. Observa si val la pena haver creat l'índex.

Els fitxers utilitzats serien: [bigger-postgre.py](https://github.com/Mariona-FT/Databases-DABD/blob/main/laboratori/sessio%207/bigger-postgre.py) i [consulta_bigger-postge.py](https://github.com/Mariona-FT/Databases-DABD/blob/main/laboratori/sessio%207/consulta_bigger-postge.py)

Abans índex:
```
~/DABD/sessio7$ python3 bigger-postgre.py
90 comptes will be inserted.
50 adreces will be inserted.
100 titulars will be inserted.
400 contractes will be inserted
```
```
~/DABD/sessio7$ python3 consulta_bigger-postge.py 
Fem 10000 cerques
Temps total:  0:00:01.319332
```
**Crear índex:**
```
=> CREATE INDEX idx_contractes_owner_hash ON contractes USING hash(owner);
CREATE INDEX
```
Despres Index hash:
```
:~/DABD/sessio7$ python3 consulta_bigger-postge.py 
Fem 10000 cerques
Temps total:  0:00:01.269235
```
**Crear índex:**
```
=> CREATE INDEX idx_contractes_owner_btree ON contractes USING btree(owner);
CREATE INDEX
```
Despres Index btree:
```
~/DABD/sessio7$ python3 consulta_bigger-postge.py 
Fem 10000 cerques
Temps total:  0:00:01.237861
```

5.c) Desprès prova de fer 10.000 consultes sense índexx, amb un índex btree i amb un índex hash en la columna owner de la taula contractes, havent creat 900 comptes, 500 adreces, 1000 titulars i 4000 contractes. Observa si val la pena haver creat l'índex.

Els fitxers utilitzats serien: [bigger-postgre.py](https://github.com/Mariona-FT/Databases-DABD/blob/main/laboratori/sessio%207/bigger-postgre.py) i [consulta_bigger-postge.py](https://github.com/Mariona-FT/Databases-DABD/blob/main/laboratori/sessio%207/consulta_bigger-postge.py)

Abans index:
```
~/DABD/sessio7$ python3 bigger-postgre.py 
900 comptes will be inserted.
500 adreces will be inserted.
1000 titulars will be inserted.
4000 contractes will be inserted.
```
```
~/DABD/sessio7$ python3 consulta_bigger-postge.py 
Fem 10000 cerques
Temps total:  0:00:03.261312
```
**Crear index:**
```
=> CREATE INDEX idx_contractes_owner_hash ON contractes USING hash(owner);
CREATE INDEX
```
Despres Index hash:
```
~/DABD/sessio7$ python3 consulta_bigger-postge.py 
Fem 10000 cerques
Temps total:  0:00:01.294420
```
**Crear index:**
```
=> CREATE INDEX idx_contractes_owner_btree ON contractes USING btree(owner);
CREATE INDEX
```
Despres Index btree:
```
~/DABD/sessio7$ python3 consulta_bigger-postge.py 
Fem 10000 cerques
Temps total:  0:00:01.098020
```

### PER L'ENTREGA:
Deixar taules bd amb  MySQL i PostgreSQL del servidor ubiwan i a les respostes del qüesionari.
 - Cal que en les dues bases de dades hi hagin creats 900 comptes, 500 adreces, 1000 titulars i 4000 contractes
 - Un índex en la columna owner de la taula contractes.
 
 **Confirmar en mysql:**
```
mysql> SELECT COUNT(*) FROM comptes;
+----------+
| COUNT(*) |
+----------+
|      900 |
+----------+
1 row in set (0.00 sec)

mysql> SELECT COUNT(*) FROM adreces;
+----------+
| COUNT(*) |
+----------+
|      500 |
+----------+
1 row in set (0.00 sec)

mysql> SELECT COUNT(*) FROM titulars;
+----------+
| COUNT(*) |
+----------+
|     1000 |
+----------+
1 row in set (0.00 sec)

mysql> SELECT COUNT(*) FROM contractes;
+----------+
| COUNT(*) |
+----------+
|     4000 |
+----------+
1 row in set (0.00 sec)

mysql> SHOW INDEX FROM contractes;
+------------+------------+----------------------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+---------+------------+
| Table      | Non_unique | Key_name             | Seq_in_index | Column_name | Collation | Cardinality | Sub_part | Packed | Null | Index_type | Comment | Index_comment | Visible | Expression |
+------------+------------+----------------------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+---------+------------+
| contractes |          0 | PRIMARY              |            1 | acc_id      | A         |         891 |     NULL |   NULL |      | BTREE      |         |               | YES     | NULL       |
| contractes |          0 | PRIMARY              |            2 | owner_id    | A         |        4000 |     NULL |   NULL |      | BTREE      |         |               | YES     | NULL       |
| contractes |          1 | idx_contractes_owner |            1 | owner       | A         |        4000 |     NULL |   NULL |      | BTREE      |         |               | YES     | NULL       |
+------------+------------+----------------------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+---------+------------+
3 rows in set (0.02 sec)
```
```
 ~/DABD/sessio7$ python3 consulta_bigger-mysql.py 
Fem 10000 cerques
Temps total:  0:00:01.651855

```
 **Confirmar en postgre:**
```
=> SELECT COUNT(*) FROM comptes;
 count 
-------
   900
(1 row)

=> SELECT COUNT(*) FROM adreces;
 count 
-------
   500
(1 row)

=> SELECT COUNT(*) FROM titulars;
 count 
-------
  1000
(1 row)

=> SELECT COUNT(*) FROM contractes;
 count 
-------
  4000
(1 row)
 
 => \di
 public | idx_contractes_owner_btree                                     | index | .. | contractes
 public | idx_contractes_owner_hash                                      | index | .. | contractes
```
```
 ~/DABD/sessio7$ python3 consulta_bigger-postge.py 
Fem 10000 cerques
Temps total:  0:00:01.021177
```
