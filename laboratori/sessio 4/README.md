## Instruccions utilitzades en la sessió 4:
*p.27 / 36*

descarregar les seguents carpetes en ubiwan: (dins de ubiwan!)

copiar i posar en el nostre usuari:
```
u@ubiwan:/home/public/dabd$ cp -r 03claus_foranees/ /home/est/userubi/DABD/
u@ubiwan:/home/public/dabd$ cp -r 04python_sqlinjection/ /home/est/userubi/DABD/
```


### Exercicis 03claus_foranes:
Fitxers en la carpeta: [03claus_foranees](https://github.com/Mariona-FT/Databases-DABD/tree/main/laboratori/sessio%204/03claus_foranees)

Per utilitzar el sqlite millor descarregar-ho en local:

Fitxer donat: [fabrica.db](https://github.com/Mariona-FT/Databases-DABD/blob/main/laboratori/sessio%204/03claus_foranees/fabrica.db)

Crear la base de dades per la .sql:
```
DABD/laboratori/sessio 4/03claus_foranees$ sqlite3 fabrica.db
SQLite version 3.37.2 2022-01-06 13:25:41
Enter ".help" for usage hints.

Indicar que es poden utilitzar claus foranes:
sqlite> PRAGMA foreign keys = ON;
```

Llegir el .sql dins de la base de dades creada,trobant les foreign keys del sql en el fitxer : [maqfact_foreign_keys.sql](https://github.com/Mariona-FT/Databases-DABD/blob/main/laboratori/sessio%204/03claus_foranees/maqfact_foreign_keys.sql)

```
sqlite> .read maqfact_foreign_keys.sql
Error: near line 13: in prepare, table tec already exists (1)
Error: near line 14: in prepare, table maq already exists (1)
Error: near line 15: in prepare, table evsup already exists (1)
Error: near line 16: in prepare, table supervisio already exists (1)
CREATE TABLE tec (dni int NOT NULL, dp text, PRIMARY KEY(dni));
CREATE TABLE maq (ninv int NOT NULL, fab text, PRIMARY KEY(ninv));
CREATE TABLE evsup (fh text NOT NULL, PRIMARY KEY(fh));
CREATE TABLE supervisio (
  dni int NOT NULL,
  ninv int NOT NULL,
  fh text NOT NULL,
  FOREIGN KEY (dni) REFERENCES tec ON UPDATE CASCADE, 
  FOREIGN KEY (ninv) REFERENCES maq ON UPDATE CASCADE,
  FOREIGN KEY (fh) REFERENCES evsup ON UPDATE CASCADE,
  PRIMARY KEY(fh,dni), UNIQUE(fh,ninv));
CREATE TABLE supervisio (
  dni int NOT NULL,
  ninv int NOT NULL,
  fh text NOT NULL,
  FOREIGN KEY (dni) REFERENCES tec ON UPDATE CASCADE, 
  FOREIGN KEY (ninv) REFERENCES maq ON UPDATE CASCADE,
  FOREIGN KEY (fh) REFERENCES evsup ON UPDATE CASCADE,
  PRIMARY KEY(fh,dni), UNIQUE(fh,ninv));
Error: near line 28: stepping, FOREIGN KEY constraint failed (19)
1|100|2020-03-02 08:30-10:30
2|200|2020-03-02 08:30-10:30
Error: near line 34: stepping, FOREIGN KEY constraint failed (19)
2|dp2
5|dp2
1|100|2020-03-02 08:30-10:30
5|200|2020-03-02 08:30-10:30
Error: near line 40: stepping, FOREIGN KEY constraint failed (19)

sqlite> .tables
evsup       maq         supervisio  tec 

sqlite> SELECT * FROM evsup;
2020-03-02 08:30-10:30
sqlite> SELECT * FROM maq;
200|SEAT
sqlite> SELECT * FROM supervisio;
1|100|2020-03-02 08:30-10:30
5|200|2020-03-02 08:30-10:30
sqlite> SELECT * FROM tec;
 - 
 ```

#### Exercicis 04python_sqlinjection:

Fitxers en la carpeta: [04python_sqlinjection](https://github.com/Mariona-FT/Databases-DABD/tree/main/laboratori/sessio%204/04python_sqlinjection)

En ubiwan!
(en local instal·lar: pip install psycopg2-binary )

Provar el script: [users_sqlite_inj.py](https://github.com/Mariona-FT/Databases-DABD/blob/main/laboratori/sessio%204/04python_sqlinjection/users_sqlite_inj.py) per veure les seves funcions que tindran possibles errors de injections.

S'haurà de fer un nou script per evitar la injection [user_sqlite_no_inj.py](https://github.com/Mariona-FT/Databases-DABD/blob/main/laboratori/sessio%204/04python_sqlinjection/users_sqlite_no_inj.py) 

- Crear una taula de users: 
```
./users_sqlite_inj.py -is
Creating table users
Query is: CREATE TABLE users (username text, passwd text);
```

- Crear estudiants: 
```
./users_sqlite_inj.py -a
Adding further users, leave empty username to finish
username: ona
passwd: ano
username: era
passwd: are
username: anna
passwd: anna
username:  
```

Mirar estudiants en llistat:  
```
./users_sqlite_inj.py -l
Listing full table users:
User: mar, passwd: ram
User: ona, passwd: ano
User: era, passwd: are
User: anna, passwd: anna
```

(executar ./users_sqlite_inj.py -ls si es vol veure els Queries fetes en la taula)
```
--> ./users_sqlite_inj.py -ls
Listing full table users:
Query is: SELECT * FROM users;
User: mar, passwd: ram
User: ona, passwd: ano
User: era, passwd: are
User: anna, passwd: anna
User: hola, passwd: aloh
```

#### Provar errors en la amb INJECTION:
- Crear usuari amb la contrasenya "'); drop table users;--":

 ```
./users_sqlite_inj.py -as
Adding further users, leave empty username to finish
username: tauro
passwd: '); drop table users;--
Query is: INSERT INTO users VALUES ('tauro',''); drop table users;--');
username: 
```
! Al fer un llistat es produirà error: 
```
./users_sqlite_inj.py -ls
Listing full table users:
Query is: SELECT * FROM users;
Traceback (most recent call last):
  File "./users_sqlite_inj.py", line 69, in <module>
    do_query(c, "SELECT * FROM %s;" % tabname)
  File "./users_sqlite_inj.py", line 9, in do_query
    c.execute(q)
```
    
EXPLICACIÓ: Aquí, el primer '); tanca la instrucció INSERT INTO prematurament. Després, drop table users; és una nova instrucció SQL que elimina la taula users. 
Finalment, -- és un comentari en SQL, el que significa que tot el que segueixi serà ignorat, evitant errors de sintaxi per qualsevol cosa que pugui haver després del comentari.
Borra la taula de users!

Tornar a crear taula users i crear usuaris:
```
./users_sqlite_inj.py -as
Adding further users, leave empty username to finish
username: mar
passwd: ram
Query is: INSERT INTO users VALUES ('mar','ram');
username: era
passwd: are
Query is: INSERT INTO users VALUES ('era','are');
username: hola
passwd: aloh
Query is: INSERT INTO users VALUES ('hola','aloh');
username: pep 
passwd: pep
Query is: INSERT INTO users VALUES ('pep','pep');
username: 

./users_sqlite_inj.py -ls
Listing full table users:
Query is: SELECT * FROM users;
User: mar, passwd: ram
User: era, passwd: are
User: hola, passwd: aloh
User: pep, passwd: pep
```

- Crear usuari amb nom: "'OR username LIKE '%"
```
 ./users_sqlite_inj.py -as
Adding further users, leave empty username to finish
username: rino
passwd: onir
Query is: INSERT INTO users VALUES ('rino','onir');
username: 'OR username LIKE '%
passwd: error
Query is: INSERT INTO users VALUES (''OR username LIKE '%','error');
Traceback (most recent call last):
  File "./users_sqlite_inj.py", line 55, in <module>
    do_script(c, q) # BUT NEVER CONSTRUCT A QUERY THAT WAY
  File "./users_sqlite_inj.py", line 14, in do_script
    c.executescript(q)
sqlite3.OperationalError: no such column: username
```
Es borra tot els usuaris de la taula!
```
 ./users_sqlite_inj.py -ls
Listing full table users:
Query is: SELECT * FROM users;
```

EXPLICACIÓ: Quan introduïm el nom d'usuari com ''OR username LIKE '%', estem intentant aprofitar-nos de la construcció dinàmica de la consulta SQL per manipular la lògica d'una operació de base de dades. 
El nom d'usuari s'introdueix de manera que, si fos part d'una consulta SQL ben formada, podria causar que la condició sempre es complís (a causa de la clàusula LIKE '%', que coincideix amb qualsevol cadena).


arreglar aquests problemes amb --> NO INJECTION!

Utilitzar consultes parametritzades (també anomenades declaracions preparades) en lloc de construir consultes SQL mitjançant la concatenació de cadenes. 

El fitxer modificat serà el: [user_sqlite_no_inj.py](https://github.com/Mariona-FT/Databases-DABD/blob/main/laboratori/sessio%204/04python_sqlinjection/users_sqlite_no_inj.py) 

Exemple en el codi:

Tindrà errors:
   ```
p = input("passwd: ")
q = "INSERT INTO %s VALUES ('%s','%s');" % (tabname, u, p)
do_script(c, q) # BUT NEVER CONSTRUCT A QUERY THAT WAY
   ```

   NO tindrà errors:
   ```
p = input("passwd: ")
q = "INSERT INTO %s VALUES (?,?);" % tabname
do_query(c, q, (u, p))
   ```

Mateix problema  Crear usuari amb la contrasenya "'); drop table users;--":
```
./users_sqlite_no_inj.py -as
Adding further users, leave empty username to finish
username: tauro
passwd: oruat
Query is: INSERT INTO users VALUES (?,?); with values ('tauro', 'oruat')
username: rino
passwd: ');drop table users;--
Query is: INSERT INTO users VALUES (?,?); with values ('rino', "');drop table users;--")
username: 
 
./users_sqlite_no_inj.py -ls
Listing full table users:
Query is: SELECT * FROM users; with values 
User: tauro, passwd: oruat
User: rino, passwd: ');drop table users;--
```

Ja no errors de INJECCIÓ!


### USERS EN POSTGRE SENSE INJECCIÓ
El fitxer serà: [users_postgres.py](https://github.com/Mariona-FT/Databases-DABD/blob/main/laboratori/sessio%204/04python_sqlinjection/users_postgres.py)

Canvis en el codi:
importar llibreria psycopg2:
```
import psycopg2
from psycopg2 import sql
```

Configurar bases de dades amb el postgreSQL:
```
conn = psycopg2.connect(host="ubiwan.epsevg.upc.edu", user="est_userubi", password="dB.userubi", database="est_userubi")
c = conn.cursor()

	tabname = "users"
```

Actualitzar com es fan les QUERYS: 
```
 ex: insert: do_query(c, sql.SQL("INSERT INTO {} VALUES (%s, %s);").format(sql.Identifier(tabname)), (u, p))
 (abans:  q = "INSERT INTO %s VALUES (?,?);" % tabname
        do_query(c, q, (u, p)))
```

UBIWAN:
```
./users_postgres.py -is
Creating table users
Query is: CREATE TABLE "users" (username text, passwd text); with values ()
Table not created:  relation "users" already exists

Try drop table first? [y]:y
Query is: DROP TABLE "users"; with values ()
Query is: CREATE TABLE "users" (username text, passwd text); with values ()

POSTGRE:=> \d
                 List of relations
 Schema |        Name        | Type  |    Owner     
--------+--------------------+-------+--------------
 public | accounts           | table | 
 public | adreces            | table | 
 public | comptes            | table | 
 public | contractes         | table | 
 public | movies             | table | 
 public | pets               | table | 
 public | titulars           | table | 
 public | users              | table | 
 public | view_average_score | view  | 
 public | view_average_year  | view  | 
 public | view_first_year    | view  | 
(11 rows)
```
```
./users_postgres.py -as
Adding further users, leave empty username to finish
username: pep
passwd: pep
Query is: INSERT INTO "users" VALUES (%s, %s); with values ('pep', 'pep')
username: donald
passwd: quack
Query is: INSERT INTO "users" VALUES (%s, %s); with values ('donald', 'quack')
username: carlota
passwd: reina
Query is: INSERT INTO "users" VALUES (%s, %s); with values ('carlota', 'reina')
username: pomma
passwd: reina2
Query is: INSERT INTO "users" VALUES (%s, %s); with values ('pomma', 'reina2')
username: 

POSTGRE:=> SELECT * from users;
 username | passwd  
----------+---------
 mariona  | anoriam
 rino     | onir
 pep      | pep
 donald   | quack
 carlota  | reina
 pomma    | reina2
(6 rows)
```
```
 ./users_postgres.py -ds
Deleting an user
username: donald
Query is: DELETE FROM "users" WHERE username=%s; with values ('donald',)
User donald deleted.

POSTGRE:=> SELECT * from users;
 username | passwd  
----------+---------
 mariona  | anoriam
 rino     | onir
 pep      | pep
 carlota  | reina
 pomma    | reina2
(5 rows)
```
```
./users_postgres.py -s
Checking some user
username:pep
passwd:pep
Query is: SELECT * FROM "users" WHERE username = %s AND passwd = %s; with values ('pep', 'pep')
Access granted to user: pep via passwd: pep
```
El sql extret de la base de dades en el postgres: [datausers_postgres.sql](https://github.com/Mariona-FT/Databases-DABD/blob/main/laboratori/sessio%204/04python_sqlinjection/datausers_postgres.sql)

### USERS EN MYSQL SENSE INJECCIO 
El fitxer serà: [users_mysql.py](https://github.com/Mariona-FT/Databases-DABD/blob/main/laboratori/sessio%204/04python_sqlinjection/users_mysql.py)

Des de local! (ubiwan dona errors)
```
	pip install PyMySQL
	chmod +x users_mysql.py
```

LOCAL:
```
./users_mysql.py -i
Creating table users

mysql> show tables;
+------------------------+
| Tables_in_est_userubiw |
+------------------------+
| accounts               |
| movies                 |
| pets                   |
| users                  |
| view_average           |
| view_gossos            |
+------------------------+
6 rows in set (0.01 sec)
```

```
 ./users_mysql.py -a
Adding further users, leave empty username to finish
username: mariona
passwd: anoriam
username: pep
passwd: pep
username: carlota
passwd: reina
username: donald
passwd: quack
username:

mysql> SELECT * FROM users;
+----------+---------+
| username | passwd  |
+----------+---------+
| mariona  | anoriam |
| pep      | pep     |
| carlota  | reina   |
| donald   | quack   |
+----------+---------+
4 rows in set (0.00 sec)
```
```
./users_mysql.py -d
Deleting an user
username: pep
User potentially deleted.

mysql> SELECT * FROM users;
+----------+---------+
| username | passwd  |
+----------+---------+
| mariona  | anoriam |
| carlota  | reina   |
| donald   | quack   |
+----------+---------+
3 rows in set (0.00 sec)

```
```
./users_mysql.py -ls
Listing full table users:
Query is: SELECT * FROM users; with values None
User: mariona, passwd: anoriam
User: carlota, passwd: reina
User: donald, passwd: quack

```
```
./users_mysql.py -s
Checking some user
username:mariona
passwd:anoriam
Query is: SELECT * FROM users WHERE username = %s AND passwd = %s; with values ('mariona', 'anoriam')
Access granted to user: mariona via passwd: anoriam
```
El sql extret de la base de dades en el mysql: [datausers_mysql.sql](https://github.com/Mariona-FT/Databases-DABD/blob/main/laboratori/sessio%204/04python_sqlinjection/datausers_mysql.sql)
