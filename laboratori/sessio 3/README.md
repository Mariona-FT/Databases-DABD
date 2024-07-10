## Instruccions utilitzades en la sessió 3:
*p.22 / 26*

### MYSQL:

Sortir de la meva base de dades - entrar a information_shema
```
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

### POSTGRESQL:
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

##### Normalització:

   - dni-> nom
   - nom -/-> dni
   - ...
```
                      Table "public.accounts"
  Column  |          Type          | Collation | Nullable | Default 
----------+------------------------+-----------+----------+---------
 acc_id   | bigint                 |           |          | 
 type     | character(1)           |           |          | 
 balance  | real                   |           |          | 
 owner    | character varying(40)  |           |          | 
 owner_id | integer                |           |          | 
 phone    | integer                |           |          | 
 address  | character varying(100) |           |          | 
```

 Nom de les taules:

 R1: titulars (owner_id,address) PK: owner_id  FK: adress=Adreces.address
 
 R2: adreces (address,phone)  PK: address, UNIQUEK:phone
 
 R3: comptes (acc_id, balance,type)  PK: acc_id
 
 R4: contractes (acc_id, owner_id,owner) PK:acc_id, owner_id FK: acc_id=Comptes.acc_id,  owner_id=titulars.owner_id )

Crear les taules en postgreSQL:

```
=> CREATE TABLE comptes (
acc_id bigint PRIMARY KEY NOT NULL,
balance real,
type character(1) NOT NULL);
CREATE TABLE

=> CREATE TABLE adreces(
address VARCHAR(100) PRIMARY KEY NOT NULL,
phone INT UNIQUE NOT NULL);
CREATE TABLE

=> CREATE TABLE titulars (
owner_id INT PRIMARY KEY NOT NULL,
address VARCHAR(100) NOT NULL, FOREIGN KEY (address) REFERENCES adreces(address));
CREATE TABLE

(falta posar polítiques d'actualització i borrar:  ON UPDATE CASCADE ON DELETE SET NULL )
=> CREATE TABLE titulars (
    owner_id INT PRIMARY KEY NOT NULL,
    address VARCHAR(100) NOT NULL,
    FOREIGN KEY (address) REFERENCES adreces(address) ON UPDATE CASCADE ON DELETE SET NULL
);

=> CREATE TABLE contractes (
acc_id BIGINT NOT NULL, owner_id INT NOT NULL,
owner VARCHAR(40) NOT NULL, PRIMARY KEY(acc_id, owner_id),FOREIGN KEY (owner_id) REFERENCES titulars(owner_id), FOREIGN KEY (acc_id) REFERENCES comptes(acc_id));
CREATE TABLE

(falta posar polítiques d'actualització i borrar:  ON UPDATE CASCADE ON DELETE SET NULL )
CREATE TABLE contractes (
    acc_id BIGINT NOT NULL,
    owner_id INT NOT NULL,
    owner VARCHAR(40) NOT NULL,
    PRIMARY KEY(acc_id, owner_id),
    FOREIGN KEY (owner_id) REFERENCES titulars(owner_id) ON UPDATE CASCADE ON DELETE SET NULL,
    FOREIGN KEY (acc_id) REFERENCES comptes(acc_id) ON UPDATE CASCADE ON DELETE SET NULL
);
```

Mirar la info de les taules:
```
=> \d titulars;
                      Table "public.titulars"
  Column  |          Type          | Collation | Nullable | Default 
----------+------------------------+-----------+----------+---------
 owner_id | integer                |           | not null | 
 address  | character varying(100) |           | not null | 
Indexes:
    "titulars_pkey" PRIMARY KEY, btree (owner_id)
Foreign-key constraints:
    "titulars_address_fkey" FOREIGN KEY (address) REFERENCES adreces(address)
Referenced by:
    TABLE "contractes" CONSTRAINT "contractes_owner_id_fkey" FOREIGN KEY (owner_id) REFERENCES titulars(owner_id)
```
```
=> \d contractes
                     Table "public.contractes"
  Column  |         Type          | Collation | Nullable | Default 
----------+-----------------------+-----------+----------+---------
 acc_id   | bigint                |           | not null | 
 owner_id | integer               |           | not null | 
 owner    | character varying(40) |           | not null | 
Indexes:
    "contractes_pkey" PRIMARY KEY, btree (acc_id, owner_id)
Foreign-key constraints:
    "contractes_acc_id_fkey" FOREIGN KEY (acc_id) REFERENCES comptes(acc_id)
    "contractes_owner_id_fkey" FOREIGN KEY (owner_id) REFERENCES titulars(owner_id)
```
```
=> \d adreces;
                      Table "public.adreces"
 Column  |          Type          | Collation | Nullable | Default 
---------+------------------------+-----------+----------+---------
 address | character varying(100) |           | not null | 
 phone   | integer                |           | not null | 
Indexes:
    "adreces_pkey" PRIMARY KEY, btree (address)
    "adreces_phone_key" UNIQUE CONSTRAINT, btree (phone)
Referenced by:
    TABLE "titulars" CONSTRAINT "titulars_address_fkey" FOREIGN KEY (address) REFERENCES adreces(address)
```
```
=> \d comptes;
                 Table "public.comptes"
 Column  |     Type     | Collation | Nullable | Default 
---------+--------------+-----------+----------+---------
 acc_id  | bigint       |           | not null | 
 balance | real         |           |          | 
 type    | character(1) |           | not null | 
Indexes:
    "comptes_pkey" PRIMARY KEY, btree (acc_id)
Referenced by:
    TABLE "contractes" CONSTRAINT "contractes_acc_id_fkey" FOREIGN KEY (acc_id) REFERENCES comptes(acc_id)
```

Inserts en les taules:
```
=> INSERT INTO adreces (address, phone) SELECT DISTINCT address, phone FROM accounts;
INSERT 0 23

=> INSERT INTO comptes (acc_id,balance,type) SELECT DISTINCT acc_id, balance,type FROM accounts;
INSERT 0 48

=> INSERT INTO titulars (owner_id, address) SELECT DISTINCT owner_id,address FROM accounts;
INSERT 0 25

=> INSERT INTO contractes (acc_id, owner_id, owner) SELECT DISTINCT acc_id,owner_id,owner FROM accounts;
INSERT 0 63
```


#### POSAR POLITIQUES ON UPDATE I ON DELETE FOREIGN KEYS:

TITULARS:
```
=> CREATE TABLE titulars (
owner_id INT PRIMARY KEY NOT NULL,
address VARCHAR(100) NOT NULL, FOREIGN KEY (address) REFERENCES adreces(address));
CREATE TABLE

=> ALTER TABLE titulars DROP CONSTRAINT titulars_address_fkey;
ALTER TABLE
=> alter table titulars add constraint titulars_address_fkey foreign key (address) references adreces(address) on update cascade on delete set null;
ALTER TABLE
```

CONTRACTES:
```
=> CREATE TABLE contractes (
acc_id BIGINT NOT NULL, owner_id INT NOT NULL,
owner VARCHAR(40) NOT NULL, PRIMARY KEY(acc_id, owner_id),FOREIGN KEY (owner_id) REFERENCES titulars(owner_id), FOREIGN KEY (acc_id) REFERENCES comptes(acc_id));
CREATE TABLE

=> ALTER TABLE contractes DROP CONSTRAINT contractes_acc_id_fkey;
ALTER TABLE
=> ALTER TABLE contractes DROP CONSTRAINT contractes_owner_id_fkey;
ALTER TABLE

=> ALTER TABLE contractes ADD CONSTRAINT contractes_acc_id_fkey foreign key (acc_id) REFERENCES comptes(acc_id) on update cascade on delete set null;
ALTER TABLE
=> ALTER TABLE contractes ADD CONSTRAINT contractes_owner_id_fkey foreign key (owner_id) REFERENCES titulars(owner_id) on update cascade on delete set null;
ALTER TABLE
```
Taules actualitzades:
```
=> \d titulars;
                      Table "public.titulars"
  Column  |          Type          | Collation | Nullable | Default 
----------+------------------------+-----------+----------+---------
 owner_id | integer                |           | not null | 
 address  | character varying(100) |           | not null | 
Indexes:
    "titulars_pkey" PRIMARY KEY, btree (owner_id)
Foreign-key constraints:
    "titulars_address_fkey" FOREIGN KEY (address) REFERENCES adreces(address) ON UPDATE CASCADE ON DELETE SET NULL
Referenced by:
    TABLE "contractes" CONSTRAINT "contractes_owner_id_fkey" FOREIGN KEY (owner_id) REFERENCES titulars(owner_id) ON UPDATE CASCADE ON DELETE SET NULL


=> \d contractes;
                     Table "public.contractes"
  Column  |         Type          | Collation | Nullable | Default 
----------+-----------------------+-----------+----------+---------
 acc_id   | bigint                |           | not null | 
 owner_id | integer               |           | not null | 
 owner    | character varying(40) |           | not null | 
Indexes:
    "contractes_pkey" PRIMARY KEY, btree (acc_id, owner_id)
Foreign-key constraints:
    "contractes_acc_id_fkey" FOREIGN KEY (acc_id) REFERENCES comptes(acc_id) ON UPDATE CASCADE ON DELETE SET NULL
    "contractes_owner_id_fkey" FOREIGN KEY (owner_id) REFERENCES titulars(owner_id) ON UPDATE CASCADE ON DELETE SET NULL
```
La extracció de totes les taules per sql seria:
- taula adreces : [dataadreces.sql](https://github.com/Mariona-FT/Databases-DABD/blob/main/laboratori/sessio%203/dataadreces.sql)
- taula comptes : [datacomptes.sql](https://github.com/Mariona-FT/Databases-DABD/blob/main/laboratori/sessio%203/datacomptes.sql)
- taula contractes : [datacontractes.sql](https://github.com/Mariona-FT/Databases-DABD/blob/main/laboratori/sessio%203/datacontractes.sql)
- taula titulars : [datatitulars.sql](https://github.com/Mariona-FT/Databases-DABD/blob/main/laboratori/sessio%203/datatitulars.sql)
