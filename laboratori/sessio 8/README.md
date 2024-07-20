## Instruccions utilitzades en la sessió 8:

### Transaccions:
 
 bd en sqlite taula de comptes amb 2 registres per simular persona "a" i "b" q tenen 100 € cadasun.
 
 Per fer aixo fer una bd amb sqlite amb el fitxer [comptes.db](https://github.com/Mariona-FT/Databases-DABD/blob/main/laboratori/sessio%208/comptes.db)
 ``` 
../sessio 8$ sqlite3 comptes.db
SQLite version 3.37.2 2022-01-06 13:25:41
Enter ".help" for usage hints.
sqlite> CREATE TABLE IF NOT EXISTS comptes (titular text, saldo decimal);
sqlite> INSERT INTO comptes VALUES ('a',1000), ('b',1000);
 ```

Ara que tenim creada la bd, podem provar les accions de les transaccions, en les comptes, en el script original: [transaccions.py](https://github.com/Mariona-FT/Databases-DABD/blob/main/laboratori/sessio%208/transaccions.py)

Depen de on posem el c.commit() o no, la transacció es farà o no:
Sense commit(): No es garanteix la durabilitat de la transacció. Això significa que qualsevol canvi fet en la base de dades durant la transacció pot no persistir si es tanca la connexió abans de cridar commit().

commit() després de cada execute(): Compromet la integritat de la transacció, ja que si es perd la connexió o es produeix un error entre els execute(), els canvis anteriors s'aplicaran sense aplicar tota la transacció completa, creant incoherències.

Per aixo exercici:
En la bd de [bigger.db](https://github.com/Mariona-FT/Databases-DABD/blob/main/laboratori/sessio%208/bigger.db) (sessió anterior - anar refent si cal amb el codi: [bigger.py](https://github.com/Mariona-FT/Databases-DABD/blob/main/laboratori/sessio%208/bigger.py))
- tipus interes 1%  saldo actual dels tipus C
- arrodonint a 2 decimals
- diners es TRANSFEREIXEN al compte banc: tipus S num acc_id mes petit a cada compte C
- El banc no fabrica diners, si el saldo de tots els comptes ABns i despres del a licidacio han de ser exactament iguals - de decimals 

Fer el script pensant: 
- La suma del saldo de tots els comptes abans i desprès de fer la liquidació d'interessos han de ser iguals.
- Tots els saldos han de tenir 2 decimals.
- S'ha de fer la liquidació dels interessos de tots els comptes (o de cap), no ens podem quedar a mitges pq sinó no sabrem a quins compte hem liquidat interessos i a quins no, i a un banc no li fa cap gràcia liquidar els mateixos interessos per duplicat.

Fer script seguint passos i el resultat es: [transaccions_1percent.py](https://github.com/Mariona-FT/Databases-DABD/blob/main/laboratori/sessio%208/transaccions_1percent.py)

Entrar a la bd: 
 ```
../sessio 8$ sqlite3 bigger.db 
 ```
Mirar els saldos dels type C:
 ```
sqlite> SELECT acc_id, balance FROM comptes WHERE type = 'C';
543690130861|455.85
918800789363|403.88
342825301719|16.27
137433833030|796.88
829157170292|507.06
210867867474|499.72
832318066054|371.02
..
 ```
Que han d'anar canviant(augmentant) al executar l'script

Trobar el compte del banc:
 ```
sqlite> SELECT acc_id, balance FROM comptes WHERE type = 'S' ORDER BY acc_id LIMIT 1;
acc_id|balance
107808452693|317.76
 ```
Que anira canviant (decreixent) al excutar l'script

Si dona error de poc saldo del banc anar-lo actualitzant:
 ```
sqlite> UPDATE comptes SET balance=1800.00 WHERE acc_id=107808452693;
 ```

### Disparadors
 
 Des de postgre de ubiwan entrar: 
``/: psql -h ubiwan.epsevg.upc.edu -U est_userubi -W``

Crear la taula de descoberts: 
 ```
=> CREATE TABLE descoberts (
    acc_id bigint PRIMARY KEY,
    balance decimal
);
CREATE TABLE
 ```

Crear una funció i **el disparador**: 
 ```
=> CREATE FUNCTION inserir_descoberts() RETURNS trigger AS $marca$
 BEGIN
  INSERT INTO descoberts VALUES (NEW.acc_id, NEW.balance);
  RETURN NEW;
 END;
$marca$ LANGUAGE plpgsql;

CREATE TRIGGER t1
AFTER UPDATE OF balance ON comptes
FOR EACH ROW WHEN (NEW.balance < 0)
EXECUTE PROCEDURE inserir_descoberts();
CREATE FUNCTION
CREATE TRIGGER
 ```
Ara per provar-ho hem de tenir un saldo mes petit a 0 en comptes, i veure si el trigger fa que es guardi en la taula de descoberts: 
 ```
=> INSERT INTO comptes (acc_id, type, balance) VALUES ('639632076', 'C', 500.00);
INSERT 0 1
=> SELECT * FROM comptes  WHERE acc_id = '639632076';
  acc_id   | type | balance 
-----------+------+---------
 639632076 | C    |     500
 ```

 Si canviem el balance en negatiu, i tornem a veure la taula de descoberts podem veure que s'ha insertat correctament: 
  ```
=> UPDATE comptes SET balance = -balance WHERE acc_id = '639632076';
UPDATE 1

=> SELECT * FROM descoberts;
  acc_id   | balance 
-----------+---------
 639632076 |    -500
(1 row)
 ```

On es pot veure que s'ha insertat si el balace es negatiu

Fer **el segon disparador**: 
 ```
=> CREATE TRIGGER t2
AFTER INSERT ON descoberts
FOR EACH ROW
EXECUTE PROCEDURE inserir_descoberts();
CREATE TRIGGER
 ```

Pero si es va canviant el balance de positiu a negatiu donarà error de doble key en la classe:
 ```
=> UPDATE comptes SET balance = -balance WHERE acc_id = '639632076';
ERROR:  duplicate key value violates unique constraint "descoberts_pkey"
DETALLE:  Key (acc_id)=(639632076) already exists.
CONTEXTO:  SQL statement "INSERT INTO descoberts VALUES (NEW.acc_id, NEW.balance)"

PL/pgSQL function inserir_descoberts() line 3 at SQL statement
=> SELECT * FROM descoberts;
  acc_id   | balance 
-----------+---------
 639632076 |    -500
(1 row)
 ```
Borrar el antic trigger i referlo:
 ```
DROP TRIGGER t2 ON descoberts;

=> CREATE OR REPLACE FUNCTION eliminar_descoberts() RETURNS trigger AS $$
BEGIN
  IF NEW.balance >= 0 THEN
    DELETE FROM descoberts WHERE acc_id = NEW.acc_id;
  END IF;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;
CREATE FUNCTION

=> CREATE TRIGGER eliminar_si_positiu
AFTER UPDATE OF balance ON comptes
FOR EACH ROW WHEN (NEW.balance >= 0)
EXECUTE PROCEDURE eliminar_descoberts();
CREATE TRIGGER
 ```
Modificar la funció d'inserir per fer updates o inserts depenen si ja existeixen a la taula o no i evitar les duplicades:
 ```
=> CREATE OR REPLACE FUNCTION inserir_descoberts() RETURNS trigger AS $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM descoberts WHERE acc_id = NEW.acc_id) THEN
    INSERT INTO descoberts VALUES (NEW.acc_id, NEW.balance);
  ELSE
    UPDATE descoberts SET balance = NEW.balance WHERE acc_id = NEW.acc_id;
  END IF;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;
CREATE FUNCTION
 ```
 Es pot veure que funciona amb el següent exemple: 
 ```
=> SELECT * FROM descoberts;
  acc_id   | balance 
-----------+---------
 639632076 |    -500
(1 row)

=> UPDATE comptes SET balance = -balance WHERE acc_id = '639632076';
UPDATE 1

=> SELECT * FROM descoberts;
 acc_id | balance 
--------+---------
(0 rows)

=> UPDATE comptes SET balance = -balance WHERE acc_id = '639632076';
UPDATE 1

=> SELECT * FROM descoberts;
  acc_id   | balance 
-----------+---------
 639632076 |    -500
(1 row)
 ```
