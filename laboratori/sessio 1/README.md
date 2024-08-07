## Instruccions utilitzades en la sessió 1:
*p.0/13*

#### Instal·lar SQLite3
	
   instruccions SQL acaben en ;
	
   instruccions NO SQL precedides per . punt => .exit .databases .tables .schema
			.mode .output .import . read

Crear nou fitxer: sqlite fitxer.db == Obrir bades de dades 
taula bàsica de contactes:
```
sqlite> CREATE TABLE contactes (
   ...> id INTEGER,
   ...> firstname TEXT,
   ...> lastname TEXT NOT NULL,
   ...> email TEXT NOT NULL UNIQUE,
   ...> PRIMARY KEY(id) 
   ...> );
sqlite> .tables
contactes

sqlite> INSERT INTO contactes VALUES(1,'ola','gonazalez','aa@gmail.com');
sqlite> SELECT* FROM contactes;
1|ola|gonazalez|aa@gmail.com
```
Borrar una taula:
```
sqlite> DROP TABLE accounts;
```

Crear taula accounts:
```
sqlite> CREATE TABLE accounts (
   ...> acc_id INTEGER,
   ...> type CHAR(1),
   ...> balance REAL,
   ...> owner TEXT,
   ...> owner_id INTEGER,
   ...> phone INTEGER,
   ...> address TEXT)
   ...> ;
```
Importar valors del .txt a la taula:
```
sqlite> .import accounts.txt accounts
```
Veure si s’han inserit correctament:
```
sqlite> SELECT * FROM accounts;
acc_id|type|balance|owner|owner_id|phone|address
161320011440|P|1763.68|Tomé Cecial|6463525|223242|Camino de Criptana 2, Argamasilla
161320011440|P|1763.68|Sancho Panza|6532345|222333|Corrales s/n, Argamasilla
111930116980|C|1564.27|Álvaro Tarfe|6112452|334455|Avellaneda 2, Granada
```
Crear taules +inserir des de .sql:
```
 sqlite3 accounts2.db < accounts.sql 
```
#### Consultes:

bd: accounts
types : acc_id|type|balance|owner|owner_id|phone|address

- Tots dnis i únic:  
```
sqlite> SELECT DISTINCT owner_id FROM accounts;
```
- Dni persona en particular:  
```
sqlite> SELECT owner_id FROM accounts WHERE owner ='Pedro Alonso';
6564321
6564321
```
- Comptes saldo superior 1000:  
```
sqlite> SELECT owner FROM accounts WHERE balance <1000;
Caballero de los Espejos
Pedro Alonso
Roque Guinart
```
- Comptes q no son tipus L: 
```
sqlite> SELECT  acc_id,owner,type FROM accounts WHERE type !='L';
161320011440|Tomé Cecial|P
161320011440|Sancho Panza|P
111930116980|Álvaro Tarfe|C
134300219657|Sancho de Azpetia|C
```
- Saldo disponible per cadascun titulars (sumant comptes )sense repeticions: 
```
sqlite> SELECT owner,balance, SUM(balance) AS total_balance FROM accounts GROUP BY owner_id;
Ginés de Pasamonte|1551.99|11624.81
Vivaldo Cachopín|1243.68|1243.68
Sancho de Azpetia|1438.91|4139.06
```
- Nom i telf sense repeticions dni del alonso quijano (subquerys):
``` 
sqlite> SELECT DISTINCT owner, phone FROM accounts WHERE owner_id = (SELECT owner_id FROM accounts WHERE owner = 'Alonso Quijano' LIMIT 1);
Alonso Quijano|213243
Caballero de la Triste Figura|213243
```

- Compte saldo major: 
```
sqlite> SELECT * FROM  accounts ORDER BY balance DESC LIMIT 1;
119774916201|C|9818.59|Alonso López|6656223|292827|Camino Alcobendas 10, Baeza
```
- Compte saldo menor:
```
sqlite> SELECT * FROM accounts WHERE balance > 0 ORDER BY balance ASC LIMIT 1;
171174310952|C|28.89|Caballero de la Blanca Luna|6435323|234678|Mayor 11, Argamasilla
```
- Nom titulars sense repeticions comencen amb "Caballero de":
```
sqlite> SELECT DISTINCT owner FROM accounts WHERE  owner LIKE 'Caballero de%' ;
owner
Caballero de los Espejos
Caballero del Verde Gabán
Caballero de la Triste Figura
Caballero de la Blanca Luna
```
- Titular que té el major saldo sumant tots els seus comptes (és el 6435323 amb 17351.02 eur):
```
SELECT owner_id, SUM(balance) AS total_balance FROM accounts GROUP BY owner_id ORDER BY total_balance DESC LIMIT 1;
owner_id|total_balance
6435323|17351.02
```
- Titular que té el menor saldo sumant tots els seus comptes (és el 6152436 amb 687.78 eur): 
```
SELECT owner_id, SUM(balance) AS total_balance FROM accounts GROUP BY owner_id ORDER BY total_balance ASC LIMIT 1;
owner_id|total_balance
6152436|687.78
```
- Saldo total i saldo mig de tots els comptes del banc arrodonit a 2 decimals (106118.38 eur i 2210.80 eur respectivament):
```
sqlite> SELECT ROUND(SUM(balance), 2) AS total_balance, ROUND(AVG(balance), 2) AS average_balance FROM accounts;
total_balance|average_balance
141079.78|2239.36
```
-bDNI de tots els titulars, sense repeticions, amb el número de comptes que té cada titular:

Llistat amb el número de titulars amb un compte, número de titulars amb dos comptes, ... (Ha de donar 1—8, 2—4, 3—10, 4—1, 6—1, 7—1):
```
sqlite> WITH Counts AS (
  SELECT owner_id, COUNT(*) AS num_accounts
  FROM accounts
  GROUP BY owner_id
)
SELECT num_accounts, COUNT(*) AS number_of_owners
FROM Counts
GROUP BY num_accounts
ORDER BY num_accounts;
num_accounts|number_of_owners
1|8
2|4
3|10
4|1
6|1
7|1
```
- Comptes, sense repeticions, amb el número de titulars que té cada compte:
```
sqlite> SELECT acc_id , COUNT (owner_id) AS number_of_o 
   ...> FROM accounts
   ...> GROUP BY owner_id;
acc_id|number_of_o
155432214678|3
183384214435|1
134300219657|3
111930116980|2
101790319782|3
122812616034|1
185121112058|3
198270715673|1
108210513275|7
```
