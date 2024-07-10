## Instruccions utilitzades en la sessió 2:
*p.13 / 22*

### MYSQL:

 INSTAL·LAR:
 - msql:  sudo apt install mysql-client-core-8.0
 - aplicació msql workbench per connectar-se remotament en les bd

Connectar-se al ubiwan utilitzant l'usuari: ssg userubiwan@ubiwan.epsevg.upc.edu

Entrar a les mysql del servidor : 
```
mysql -u est_userubiwan -p 
Enter password: dB.userubiwan
```
Mirar databases: 
```
mysql> show databases;
+--------------------+
| Database           |
+--------------------+
| est_userubiw       |
| information_schema |
| performance_schema |
+--------------------+
3 rows in set (0.00 sec)
```
entrar a la base de dades del usuari:
```
mysql> \u est_userubiwan
```
Mirar taules dins de la base de dades:
```
mysql> show tables;
```
Mirar ESQUEMA taula:
```
mysql> desc pets;
+-----------+------+------+-----+---------+-------+
| Field     | Type | Null | Key | Default | Extra |
+-----------+------+------+-----+---------+-------+
| nom       | text | YES  |     | NULL    |       |
| data_naix | int  | YES  |     | NULL    |       |
| tipus     | text | YES  |     | NULL    |       |
| pes       | int  | YES  |     | NULL    |       |
+-----------+------+------+-----+---------+-------+
4 rows in set (0.00 sec)
```
#### Crear taula de mascotes:
```
mysql> CREATE TABLE pets ( nom TEXT, data_naix INTEGER, tipus TEXT, pes INTEGER);
Query OK, 0 rows affected (0.07 sec)

Insertar varies mascotes de gats i gossos:
mysql> INSERT INTO pets VALUES('lola',120802,'gos',15);
mysql> INSERT INTO pets VALUES('perry',040810,'cavall',78);
mysql> INSERT INTO pets VALUES('cutie',021201,'gat',7);
mysql> INSERT INTO pets VALUES('po',021207,'gat',13);
mysql> INSERT INTO pets VALUES('nina',040707,'gos',11);
mysql> INSERT INTO pets VALUES('taques',031022,'gos',8);
```
#### Consultes bàsiques:
```
mysql> SELECT nom,tipus FROM pets WHERE tipus='gat';
+-------+-------+
| nom   | tipus |
+-------+-------+
| cutie | gat   |
| po    | gat   |
+-------+-------+

mysql> SELECT nom,tipus FROM pets WHERE tipus='gos';
+--------+-------+
| nom    | tipus |
+--------+-------+
| lola   | gos   |
| nina   | gos   |
| taques | gos   |
+--------+-------+
```
- Fer un update del pes d'un gat:
```
mysql> SELECT nom,tipus,pes FROM pets WHERE tipus='gat';
+-------+-------+------+
| nom   | tipus | pes  |
+-------+-------+------+
| cutie | gat   |    7 |
| po    | gat   |   13 |
+-------+-------+------+
2 rows in set (0.00 sec)

mysql> UPDATE pets SET pes=10 WHERE nom='cutie';
Query OK, 1 row affected (0.01 sec)
Rows matched: 1  Changed: 1  Warnings: 0

mysql> SELECT nom,tipus,pes FROM pets WHERE tipus='gat';
+-------+-------+------+
| nom   | tipus | pes  |
+-------+-------+------+
| cutie | gat   |   10 |
| po    | gat   |   13 |
+-------+-------+------+
2 rows in set (0.00 sec)
```
- Eliminar un gos que ha passat a una altra vida:
```
mysql> DELETE FROM pets WHERE nom=taques;
ERROR 1054 (42S22): Unknown column 'taques' in 'where clause'
mysql> DELETE FROM pets WHERE nom='taques';
Query OK, 1 row affected (0.02 sec)

mysql> SELECT nom,tipus FROM pets WHERE tipus='gos';
+------+-------+
| nom  | tipus |
+------+-------+
| lola | gos   |
| nina | gos   |
+------+-------+
2 rows in set (0.00 sec)
```
- Create view de nomes gossos:
```
mysql> CREATE VIEW view_gossos AS SELECT nom,tipus,data_naix FROM pets WHERE tipus='gos' ; 
Query OK, 0 rows affected (0.02 sec)

mysql> SELECT * FROM view_gossos;
+------+-------+-----------+
| nom  | tipus | data_naix |
+------+-------+-----------+
| lola | gos   |    120802 |
| nina | gos   |     40707 |
+------+-------+-----------+
2 rows in set (0.00 sec)
```
- Create view de la mitjana dels pesos per tipus de mascota:
```
mysql> CREATE VIEW view_average_pets AS SELECT tipus,AVG(pes) AS mitjana FROM pets GROUP BY tipus;
Query OK, 0 rows affected (0.01 sec)

mysql> SELECT *  FROM view_average_pets;
+--------+---------+
| tipus  | mitjana |
+--------+---------+
| gos    | 13.0000 |
| cavall | 78.0000 |
| gat    | 11.5000 |
+--------+---------+
3 rows in set (0.00 sec)
```
- Seleccionar una caracteristica de una vista:
```
mysql> SELECT mitjana  FROM view_average_pets;
+---------+
| mitjana |
+---------+
| 13.0000 |
| 78.0000 |
| 11.5000 |
+---------+
3 rows in set (0.00 sec)
```
- Eliminar una vista:
```
mysql> DROP VIEW view_average_pets;
Query OK, 0 rows affected (0.01 sec)
```

### IMPORTAR I EXPORTAR MYSQL: 

IMPORTAR fitxers a mysql:

-> entrar a ubiwan

-> fitxer a importar en ubiwan
``` mysql -u est_userubi -p est_userubi < accounts.sql  Enter password: dB.userubi```

(en el cas accounts error int acc_id fora de rang -> canviar a bigint)
```
mysql> show tables;
+------------------------+
| Tables_in_est_userubiw |
+------------------------+
| accounts               |
| p                      |
| pets                   |
| view_average           |
| view_gossos            |
+------------------------+
5 rows in set (0.00 sec)
```
EXPORTAR fitxer de mysql:

-> tenir la taula que es vulgui importar a mysql creada
 ```
 mysqldump -u est_userubi -p est_userubi pets > datapets.sql --column-statistics=0 --no-tablespaces
Enter password: dB.userubi

(mysqldump -u username -p databasename pets --no-tablespaces --compatible=ansi > pets.sql )

ub@ubiwan:~$ ls
 DABD   PROP   a.wav          datapets.sql                         
 INTE   REIN   accounts.sql   fotos
 MIDA   XAMU   assignatures   
```

### IMPORTAR I EXPORTAR MYSQL POSTGRESQL:

Connectar-se al ubiwan utilitzant l'usuari: ssh userubiwan@ubiwan.epsevg.upc.edu
```
ubi@ubiwan:~$ psql -h ubiwan.epsevg.upc.edu -U est_userubi -W
Password: dB.userubi

psql (12.18 (Ubuntu 12.18-0ubuntu0.20.04.1))
SSL connection (protocol: TLSv1.3, cipher: TLS_AES_256_GCM_SHA384, bits: 256, compression: off)
Type "help" for help.
```

(Ja estarem a la nostra base de dades)
-  \l mostra les bases de dades
-  \c canviar de bases de dades
-  \d  mostra les taules
- \d table/view esquema de la taula

#### Crear taula de pelicules:
```
=> CREATE TABLE movies (
name TEXT,
year INT,
director TEXT,
score INT);
```

Insertar varies pelicules del Stanley Kubrik i Quentin Tarnantino
```
INSERT INTO movies VALUES ('the shining',1980,'Stanley Kubrick',8);
=> INSERT INTO movies VALUES ('2001 a space odyssey',1968,'Stanley Kubrick',9);
=> INSERT INTO movies VALUES ('Operation Lune',2002,'Stanley Kubrick',7);
=> INSERT INTO movies VALUES ('Room 237',2012,'Stanley Kubrick',6);
=> INSERT INTO movies VALUES ('The hateful eight',2015,'Quentin Tarantino',8);
=> INSERT INTO movies VALUES ('Pulp Fiction',1994,'Quentin Tarantino',9);
=> INSERT INTO movies VALUES ('Once upon a time in hollywood',2019,'Quentin Tarantino',7);
=> INSERT INTO movies VALUES ('Jackie Brown',1997,'Quentin Tarantino',8);
=> INSERT INTO movies VALUES ('From dusk till dawn',1996,'Quentin Tarantino',7);
```
Esquema taula:
```
=> \d movies 
                Table "public.movies"
  Column  |  Type   | Collation | Nullable | Default 
----------+---------+-----------+----------+---------
 name     | text    |           |          | 
 year     | integer |           |          | 
 director | text    |           |          | 
 score    | integer |           |          | 

=> SELECT * FROM movies;
             name              | year |     director      | score 
-------------------------------+------+-------------------+-------
 the shining                   | 1980 | Stanley Kubrick   |     8
 2001 a space odyssey          | 1968 | Stanley Kubrick   |     9
 Operation Lune                | 2002 | Stanley Kubrick   |     7
 Room 237                      | 2012 | Stanley Kubrick   |     6
 The hateful eight             | 2015 | Quentin Tarantino |     8
 Pulp Fiction                  | 1994 | Quentin Tarantino |     9
 Once upon a time in hollywood | 2019 | Quentin Tarantino |     7
 Jackie Brown                  | 1997 | Quentin Tarantino |     8
 From dusk till dawn           | 1996 | Quentin Tarantino |     7
(9 rows)
```

### Consultes básiques:
- Ordenades per director ascendent:
```
SELECT * FROM movies ORDER BY director ASC;
             name              | year |     director      | score 
-------------------------------+------+-------------------+-------
 From dusk till dawn           | 1996 | Quentin Tarantino |     7
 The hateful eight             | 2015 | Quentin Tarantino |     8
 Pulp Fiction                  | 1994 | Quentin Tarantino |     9
 Once upon a time in hollywood | 2019 | Quentin Tarantino |     7
 Jackie Brown                  | 1997 | Quentin Tarantino |     8
 2001 a space odyssey          | 1968 | Stanley Kubrick   |     9
 Operation Lune                | 2002 | Stanley Kubrick   |     7
 Room 237                      | 2012 | Stanley Kubrick   |     6
 the shining                   | 1980 | Stanley Kubrick   |     8
(9 rows)

=> SELECT * FROM movies ORDER BY director DESC;
             name              | year |     director      | score 
-------------------------------+------+-------------------+-------
 the shining                   | 1980 | Stanley Kubrick   |     8
 2001 a space odyssey          | 1968 | Stanley Kubrick   |     9
 Operation Lune                | 2002 | Stanley Kubrick   |     7
 Room 237                      | 2012 | Stanley Kubrick   |     6
 The hateful eight             | 2015 | Quentin Tarantino |     8
 Pulp Fiction                  | 1994 | Quentin Tarantino |     9
 Once upon a time in hollywood | 2019 | Quentin Tarantino |     7
 Jackie Brown                  | 1997 | Quentin Tarantino |     8
 From dusk till dawn           | 1996 | Quentin Tarantino |     7
(9 rows)
```

- Les del mateix director per puntuació descendent:
```
=> SELECT m.*  FROM movies m WHERE m.score= (SELECT MIN(m2.score) FROM movies m2  WHERE m2.director=m.director)
;
             name              | year |     director      | score 
-------------------------------+------+-------------------+-------
 Room 237                      | 2012 | Stanley Kubrick   |     6
 Once upon a time in hollywood | 2019 | Quentin Tarantino |     7
 From dusk till dawn           | 1996 | Quentin Tarantino |     7
(3 rows)

=> SELECT m.*  FROM movies m WHERE m.score= (SELECT MAX(m2.score) FROM movies m2  WHERE m2.director=m.director)
;
         name         | year |     director      | score 
----------------------+------+-------------------+-------
 2001 a space odyssey | 1968 | Stanley Kubrick   |     9
 Pulp Fiction         | 1994 | Quentin Tarantino |     9
(2 rows)
```

- Crear view mitjana de puntuació per director:
```
CREATE VIEW view_average_score AS SELECT director,AVG(score) AS average FROM movies GROUP BY director;
CREATE VIEW
=> SELECT * FROM view_average_score;
     director      |      average       
-------------------+--------------------
 Quentin Tarantino | 7.8000000000000000
 Stanley Kubrick   | 7.5000000000000000
(2 rows)
```

- Mitjana any per director:
```
=> CREATE VIEW view_average_year AS SELECT director,AVG(year) AS average FROM movies GROUP BY director;
CREATE VIEW
=> SELECT * FROM view_average_year;
     director      |        average        
-------------------+-----------------------
 Quentin Tarantino | 2004.2000000000000000
 Stanley Kubrick   | 1990.5000000000000000
(2 rows)
```

- Any de la primera pelicula de cada director:
```
 CREATE VIEW view_first_year AS SELECT director,MIN(year) AS min_year FROM movies GROUP BY director;
CREATE VIEW
=> SELECT * FROM view_first_year;
     director      | min_year 
-------------------+----------
 Quentin Tarantino |     1994
 Stanley Kubrick   |     1968
(2 rows)
```

- Actualitzar valor de puntuació:
```
=> SELECT * FROM movies;
             name              | year |     director      | score 
-------------------------------+------+-------------------+-------
 the shining                   | 1980 | Stanley Kubrick   |     8
 2001 a space odyssey          | 1968 | Stanley Kubrick   |     9
 Operation Lune                | 2002 | Stanley Kubrick   |     7
 Room 237                      | 2012 | Stanley Kubrick   |     6
 The hateful eight             | 2015 | Quentin Tarantino |     8
 Pulp Fiction                  | 1994 | Quentin Tarantino |     9
 Once upon a time in hollywood | 2019 | Quentin Tarantino |     7
 Jackie Brown                  | 1997 | Quentin Tarantino |     8
 From dusk till dawn           | 1996 | Quentin Tarantino |     7
(9 rows)

=> UPDATE movies SET score=10 WHERE name='Pulp Fiction';
UPDATE 1
=> SELECT * FROM movies;
             name              | year |     director      | score 
-------------------------------+------+-------------------+-------
 the shining                   | 1980 | Stanley Kubrick   |     8
 2001 a space odyssey          | 1968 | Stanley Kubrick   |     9
 Operation Lune                | 2002 | Stanley Kubrick   |     7
 Room 237                      | 2012 | Stanley Kubrick   |     6
 The hateful eight             | 2015 | Quentin Tarantino |     8
 Once upon a time in hollywood | 2019 | Quentin Tarantino |     7
 Jackie Brown                  | 1997 | Quentin Tarantino |     8
 From dusk till dawn           | 1996 | Quentin Tarantino |     7
 Pulp Fiction                  | 1994 | Quentin Tarantino |    10
(9 rows)
```

### IMPORTAR I EXPORTAR POSTGRESQL:

IMPORTAR sql en postgre:

-> entrar a ubiwan

-> tenir la sql en la mateixa carpeta q l'execució

En ubiwan:
```
userubiwan@ubiwan:~$ psql -h ubiwan.epsevg.upc.edu  -U est_userubiwan est_userubiwan -f accounts.sql 
```

En el postgre:
```
-> \d
                 List of relations
 Schema |        Name        | Type  |    Owner     
--------+--------------------+-------+--------------
 public | accounts           | table | 
 public | movies             | table | 
 public | view_average_score | view  | 
 public | view_average_year  | view  | 
 public | view_first_year    | view  | 
(5 rows)
```

EXPORTAR sql en postgre:

-> entrar a ubiwan

-> posar totes les opcions seguents per possibles problemes d'incompatibilitat:
	```--no-tablespaces--no-owner --no-acl --column-inserts```

En el postgre: 
```
userubiwan@ubiwan:~$ pg_dump -h ubiwan.epsevg.upc.edu -U est_userubiwan est_userubiwan -t movies > datamovies.sql --no-tablespaces --no-owner
Password: dB.userubiwan
```
En ubiwan: 
```
userubiwan@ubiwan:~$ ls
 DABD   MIDA   REIN   accounts.sql   datamovies.sql  'datapets.sql--column-statistics=0'   elasticsearch-logs
 INTE   PROP   XAMU   assignatures   datapets.sql     elasticsearch-data                   fotos
```

### EXPORTAR LA TAULA DE MOVIES.SQL I IMPORTAR-LES A MYSQL:

Exportar en postgre:

En ubiwan: 
```
userubiwan@ubiwan:~$ pg_dump -h ubiwan.epsevg.upc.edu -U est_userubiwan est_userubiwan
-t movies --no-tablespaces --no-owner --no-acl --column-inserts  > datamovie.sql
Password: dB.userubiwan

userubiwan@ubiwan:~$ ls
 DABD   MIDA   REIN   accounts.sql   datamovie.sql  'datapets.sql--column-statistics=0'   elasticsearch-logs
 INTE   PROP   XAMU   assignatures   datapets.sql     elasticsearch-data                   fotos
 ```

Importar en mysql:

- Treure MANUALMENT en el .sql 

- TOTES les lines de SET time (comentar-les)

- TOTS ELS public. del CREATE i INSERT 

Ara ja serà compatible amb mysql:

En mysql:
```
userubiwan@ubiwan:~$ mysql -h ubiwan.epsevg.upc.edu -u est_userubiwan -p est_userubiwan <  datamovie.sql 
Enter password: dB.userubiwan

mysql> show tables;
+------------------------+
| Tables_in_est_userubiw |
+------------------------+
| accounts               |
| movies                 |
| p                      |
| pets                   |
| view_average           |
| view_gossos            |
+------------------------+
6 rows in set (0.00 sec)

```

Sortir de la meva base de dades  - entrar a information_shema
```
/ **INFORMATION SCHEMA ** /
mysql> \u information_schema

mysql> SELECT table_name, column_name, column_type  FROM columns WHERE table_name='accounts';
+------------+-------------+--------------+
| TABLE_NAME | COLUMN_NAME | COLUMN_TYPE  |
+------------+-------------+--------------+
| accounts   | acc_id      | bigint       |
| accounts   | type        | char(1)      |
| accounts   | balance     | double       |
| accounts   | owner       | varchar(40)  |
| accounts   | owner_id    | int          |
| accounts   | phone       | int          |
| accounts   | address     | varchar(100) |
+------------+-------------+--------------+
7 rows in set (0.00 sec)
```


En postgre:
```
est_userubu=> SELECT udt_catalog, column_name, udt_name FROM information_schema.columns WHERE table_name='accounts';
 udt_catalog  | column_name | udt_name 
--------------+-------------+----------
 est_userubiw | acc_id      | int8
 est_userubiw | type        | bpchar
 est_userubiw | balance     | float4
 est_userubiw | owner       | varchar
 est_userubiw | owner_id    | int4
 est_userubiw | phone       | int4
 est_userubiw | address     | varchar
(7 rows)

```
