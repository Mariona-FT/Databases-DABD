
## Instruccions utilitzades en la sessió 10:

Optimització consultes SQL

### Teoria Postgres:

 #### Seq Scan

The Seq Scan operation scans the entire relation (table) as stored on disk (like TABLE ACCESS FULL).

#### Index Scan
The Index Scan performs a B-tree traversal, walks through the leaf nodes to find all matching entries, and fetches the corresponding table data. It is like an INDEX RANGE SCAN followed by a TABLE ACCESS BY INDEX ROWID operation. See also Chapter 1, “Anatomy of an SQL Index”.

The so-called index filter predicates often cause performance problems for an Index Scan. The next section explains how to identify them.

### Index Only Scan (since PostgreSQL 9.2)
The Index Only Scan performs a B-tree traversal and walks through the leaf nodes to find all matching entries. There is no table access needed because the index has all columns to satisfy the query (exception: MVCC visibility information). See also “Index-Only Scan: Avoiding Table Access”.

### Bitmap Index Scan / Bitmap Heap Scan / Recheck Cond
Tom Lane’s post to the PostgreSQL performance mailing list is very clear and concise.

A plain Index Scan fetches one tuple-pointer at a time from the index, and immediately visits that tuple in the table. A bitmap scan fetches all the tuple-pointers from the index in one go, sorts them using an in-memory “bitmap” data structure, and then visits the table tuples in physical tuple-location order.

**EXPLAIN:**
The structure of a query plan is a tree of plan nodes. Nodes at the bottom level of the tree are scan nodes: they return raw rows from a table. There are different types of scan nodes for different table access methods: sequential scans, index scans, and bitmap index scans. There are also non-table row sources, such as VALUES clauses and set-returning functions in FROM, which have their own scan node types. If the query requires joining, aggregation, sorting, or other operations on the raw rows, then there will be additional nodes above the scan nodes to perform these operations. Again, there is usually more than one possible way to do these operations, so different node types can appear here too. The output of EXPLAIN has one line for each node in the plan tree, showing the basic node type plus the cost estimates that the planner made for the execution of that plan node. Additional lines might appear, indented from the node's summary line, to show additional properties of the node. The very first line (the summary line for the topmost node) has the estimated total execution cost for the plan; it is this number that the planner seeks to minimize.

Copiar la taula de bigger.sql de ubiwan: 
``@ubiwan:/home/public/dabd$ cp -r 09postgresql/ /home/est/userubi/DABD/sessio10``

i descarregar el fitxer localment

Copiar la .sql en el servidor de postge localment: 
`` /DABD/laboratori/sessio 10$ psql dabd userdabd < bigger.sql ``

Ara si entrem al postge local trobarem les taules a dins creades i amb dades:
```
/laboratori/sessio 10$ psql dabd userdabd 
Password for user userdabd: 
psql (14.11 (Ubuntu 14.11-0ubuntu0.22.04.1))
Type "help" for help.

dabd=> \d
          List of relations
 Schema |   Name   | Type  |  Owner   
--------+----------+-------+----------
 public | accounts | table | userdabd
 public | names    | table | userdabd
 public | owners   | table | userdabd
(3 rows)
```

Exemples dels explains en la taula names: 
```
    dabd=> EXPLAIN SELECT * FROM names;
                            QUERY PLAN                        
    ----------------------------------------------------------
    Seq Scan on names  (cost=0.00..22.00 rows=1200 width=40)
    (1 row)

    dabd=> EXPLAIN SELECT * FROM names WHERE name<'PIPO KALIMA';
                        QUERY PLAN                        
    ---------------------------------------------------------
    Seq Scan on names  (cost=0.00..25.00 rows=400 width=40)
    Filter: (name < 'PIPO KALIMA'::text)
    (2 rows)

    dabd=> EXPLAIN SELECT * FROM names WHERE name='PIPO KALIMA';
                                    QUERY PLAN                                  
    -----------------------------------------------------------------------------
    Index Scan using names_name_key on names  (cost=0.28..8.29 rows=1 width=40)
    Index Cond: (name = 'PIPO KALIMA'::text)
    (2 rows)

    dabd=> EXPLAIN SELECT name FROM names WHERE name='PIPO KALIMA';
                                        QUERY PLAN                                    
    ----------------------------------------------------------------------------------
    Index Only Scan using names_name_key on names  (cost=0.28..8.29 rows=1 width=32)
    Index Cond: (name = 'PIPO KALIMA'::text)
    (2 rows)

    dabd=> EXPLAIN SELECT * FROM names WHERE name<'ANNA KALIMA';
                        QUERY PLAN                        
    ---------------------------------------------------------
    Seq Scan on names  (cost=0.00..25.00 rows=400 width=40)
    Filter: (name < 'ANNA KALIMA'::text)
    (2 rows)

    dabd=> EXPLAIN SELECT * FROM names WHERE name<'COCA KALIMA';
                        QUERY PLAN                        
    ---------------------------------------------------------
    Seq Scan on names  (cost=0.00..25.00 rows=400 width=40)
    Filter: (name < 'COCA KALIMA'::text)
    (2 rows)
```
Ara exemples d'explain amb JOINS:
```
    dabd=> EXPLAIN SELECT * from names n, owners o WHERE n.nif=o.own_id AND n.name=o.own_name;
                                QUERY PLAN                               
    ------------------------------------------------------------------------
    Hash Join  (cost=40.00..405.07 rows=77 width=80)
    Hash Cond: ((o.own_id = n.nif) AND (o.own_name = n.name))
    ->  Seq Scan on owners o  (cost=0.00..283.80 rows=15480 width=40)
    ->  Hash  (cost=22.00..22.00 rows=1200 width=40)
            ->  Seq Scan on names n  (cost=0.00..22.00 rows=1200 width=40)
    (5 rows)
```
Explicació de hash join:
### Hash Join
A Hash Join is more efficient for large datasets with equality conditions. It builds a hash table on the smaller (or inner) table and probes it with rows from the larger (or outer) table.
```
    dabd=> EXPLAIN SELECT * from names n, owners o;
                                   QUERY PLAN                                    
    ---------------------------------------------------------------------------------
    Nested Loop  (cost=0.00..232508.80 rows=18576000 width=80)
    ->  Seq Scan on owners o  (cost=0.00..283.80 rows=15480 width=40)
    ->  Materialize  (cost=0.00..28.00 rows=1200 width=40)
            ->  Seq Scan on names n  (cost=0.00..22.00 rows=1200 width=40)
    JIT:
    Functions: 3
    Options: Inlining false, Optimization false, Expressions true, Deforming true
    (7 rows)
```

Explicació de nested loop:
### Nested Loop
A Nested Loop Join iterates through each row of the outer table and, for each row, scans the entire inner table to find matching rows. This method is straightforward but can be inefficient for large datasets.
--> In the absence of a join condition, PostgreSQL defaults to a Nested Loop Join for performing a Cartesian product of the two tables. The optimizer materializes the intermediate results to facilitate this process.

Crear un merge join: 
A Merge Join requires both input tables to be sorted on the join key. It merges the sorted data sets efficiently, making it ideal for large data sets where sorting is feasible.
```
    dabd=> EXPLAIN SELECT *  FROM ( SELECT * FROM names ORDER BY nif, name) n  JOIN ( SELECT * FROM owners ORDER BY own_id ,own_name) o  ON n.nif = o.own_id AND n.name = o.own_name;
                                    QUERY PLAN                                   
    --------------------------------------------------------------------------------
    Merge Join  (cost=1444.44..1743.98 rows=464 width=80)
    Merge Cond: ((owners.own_id = names.nif) AND (owners.own_name = names.name))
    ->  Sort  (cost=1361.06..1399.76 rows=15480 width=40)
            Sort Key: owners.own_id, owners.own_name
            ->  Seq Scan on owners  (cost=0.00..283.80 rows=15480 width=40)
    ->  Materialize  (cost=83.37..101.37 rows=1200 width=40)
            ->  Sort  (cost=83.37..86.37 rows=1200 width=40)
                Sort Key: names.nif, names.name
                ->  Seq Scan on names  (cost=0.00..22.00 rows=1200 width=40)
    (9 rows)
```

Fer un SELECT amb 2JOINS:
```
    SELECT * from names n, owners o, accounts a WHERE n.nif=o.own_id AND n.name=o.own_name AND o.acc_id=a.acc_id;
    mateix que posar explicitament els joins:
         SELECT * from names n JOIN owners o ON n.nif=o.own_id AND n.name=o.own_name JOIN accounts a ON o.acc_id=a.acc_id;  
    
    
Hash Join (Join Intern)

Primer que només ens digui quin és el pla que utilitzaria amb els costos estimats sense que l'executi. Fixa't que un dels dos JOINs el resol amb un Hash Join (l'interior) l'altre amb un Nested Loop (l'exterior). Per què?

    EXPLAIN SELECT * from names n, owners o, accounts a WHERE n.nif=o.own_id AND n.name=o.own_name AND o.acc_id=a.acc_id;

                                        QUERY PLAN                                       
    ---------------------------------------------------------------------------------------
    Nested Loop  (cost=36.43..498.46 rows=83 width=58)
    ->  Hash Join  (cost=36.15..471.81 rows=83 width=44)
            Hash Cond: ((o.own_id = n.nif) AND (o.own_name = n.name))
            ->  Seq Scan on owners o  (cost=0.00..330.09 rows=20109 width=22)
            ->  Hash  (cost=19.26..19.26 rows=1126 width=22)
                ->  Seq Scan on names n  (cost=0.00..19.26 rows=1126 width=22)
    ->  Index Scan using accounts_pkey on accounts a  (cost=0.29..0.32 rows=1 width=14)
            Index Cond: (acc_id = o.acc_id)

-> Nested Loop (Join Extern)
    Cost: 36.43..498.46
    Files: 83
    Amplada: 58
    El Nested Loop es fa entre el resultat del Hash Join i la taula accounts utilitzant la condició o.acc_id = a.acc_id.
    ->Hash Join (Join Intern)
        Cost: 36.15..471.81
        Files: 83
        Amplada: 44
        El Hash Join es fa entre les taules names i owners utilitzant les condicions de join o.own_id = n.nif i o.own_name = n.name.
        -> Seq Scan a owners:
            Cost: 0.00..330.09
            Files: 20109
            Amplada: 22
        -> Hash:
        Cost: 19.26..19.26
        Files: 1126
        Amplada: 22

            -> Seq Scan a names:
            Cost: 0.00..19.26
            Files: 1126
            Amplada: 22

    ->Index Scan a accounts:
    Cost: 0.29..0.32
    Files: 1
    Amplada: 14
    L'index scan utilitza la clau primària accounts_pkey per trobar les files coincidents de manera eficient.
```

Hash Join per names i owners:

El Hash Join és adequat per a condicions d'igualtat i conjunts de dades relativament grans. En aquest cas, les condicions de join són (o.own_id = n.nif) i (o.own_name = n.name), que són condicions d'igualtat. El Hash Join crea una taula hash per a una de les taules (en aquest cas names) i després escaneja l'altra taula (owners) per trobar coincidències, cosa que és eficient per a aquest tipus de condicions.

Nested Loop per unir amb accounts:
Després del Hash Join, el conjunt de resultats és relativament petit (83 files). Utilitzar un Nested Loop és eficient per a petits conjunts de resultats quan s'utilitza un index scan per accedir a la taula accounts. El Nested Loop escaneja les files resultants del Hash Join i, per cada fila, utilitza l'index scan per trobar les files corresponents a accounts de manera eficient. Aquesta combinació és òptima quan es pot utilitzar un índex per accedir ràpidament a les dades.

Ara els costos de la consulta: 
```
    dabd=> EXPLAIN ANALYZE SELECT * from names n, owners o, accounts a WHERE n.nif=o.own_id AND n.name=o.own_name AND o.acc_id=a.acc_id;
                                                                QUERY PLAN                                                              
    -------------------------------------------------------------------------------------------------------------------------------------
    Nested Loop  (cost=40.28..430.19 rows=77 width=100) (actual time=0.480..42.760 rows=20109 loops=1)
    ->  Hash Join  (cost=40.00..405.07 rows=77 width=80) (actual time=0.456..9.751 rows=20109 loops=1)
            Hash Cond: ((o.own_id = n.nif) AND (o.own_name = n.name))
            ->  Seq Scan on owners o  (cost=0.00..283.80 rows=15480 width=40) (actual time=0.014..1.857 rows=20109 loops=1)
            ->  Hash  (cost=22.00..22.00 rows=1200 width=40) (actual time=0.394..0.395 rows=1126 loops=1)
                Buckets: 2048  Batches: 1  Memory Usage: 78kB
                ->  Seq Scan on names n  (cost=0.00..22.00 rows=1200 width=40) (actual time=0.006..0.146 rows=1126 loops=1)
    ->  Index Scan using accounts_pkey on accounts a  (cost=0.29..0.33 rows=1 width=20) (actual time=0.001..0.001 rows=1 loops=20109)
            Index Cond: (acc_id = o.acc_id)
    Planning Time: 0.292 ms
    Execution Time: 43.642 ms
    (11 rows)
```

### QUESTIONARI: 
Entrar a pqsl i borrar la taula accounts!
``=> DROP TABLE accounts ;``

Sortir i penjar les noves taules de [bigger.sql](https://github.com/Mariona-FT/Databases-DABD/blob/main/laboratori/sessio%2010/bigger.sql) (noms, accounts,owners)

Des de local executar: 
``psql -h ubiwan.epsevg.upc.edu -U usuari usuari < bigger.sql``

(molta estona insertant dades)

tornar a entrar al postgres i anar responent les preguntes: 
```
    laboratori/sessio 10$ psql -h ubiwan.epsevg.upc.edu -U est_userubi
```

Mirar si les taules s'han creat correctament: 
```
=> \d
                                  List of relations
 Schema |                       Name                        |   Type   |    Owner     
--------+---------------------------------------------------+----------+--------------
 public | accounts                                          | table    | *
 public | adreces                                           | table    | 
 public | auth_group                                        | table    | 
 public | auth_group_id_seq                                 | sequence | 
 public | auth_group_permissions                            | table    | 
 public | auth_group_permissions_id_seq                     | sequence | 
 public | auth_permission                                   | table    | 
 public | auth_permission_id_seq                            | sequence | 
 public | auth_user                                         | table    | 
 public | auth_user_groups                                  | table    | 
 public | auth_user_groups_id_seq                           | sequence | 
 public | auth_user_id_seq                                  | sequence | 
 public | auth_user_user_permissions                        | table    | 
 public | auth_user_user_permissions_id_seq                 | sequence | 
 public | comptes                                           | table    | 
 public | contractes                                        | table    | 
 public | descoberts                                        | table    | 
 public | django_admin_log                                  | table    | 
 public | django_admin_log_id_seq                           | sequence | 
 public | django_content_type                               | table    | 
 public | django_content_type_id_seq                        | sequence | 
 public | django_migrations                                 | table    | 
 public | django_migrations_id_seq                          | sequence | 
 public | django_session                                    | table    | 
 public | movies                                            | table    | 
 public | names                                             | table    | *
 public | owners                                            | table    | *
 public | pets                                              | table    | 
 public | producte_productcategory                          | table    | 
 public | producte_productcategory_id_seq                   | sequence | 
 public | producte_productcategory_product_templates        | table    | 
 public | producte_productcategory_product_templates_id_seq | sequence | 
 public | producte_producttemplate                          | table    | 
 public | producte_producttemplate_id_seq                   | sequence | 
 public | producte_productvariant                           | table    | 
 public | producte_productvariant_id_seq                    | sequence | 
 public | titulars                                          | table    | 
 public | users                                             | table    | 
 public | view_average_score                                | view     | 
 public | view_average_year                                 | view     | 
 public | view_first_year                                   | view     | 
(41 rows)
```

Mode: El nom de l'usuari es registrarà i es mostrarà amb les respostes
1. 
```
EXPLAIN SELECT * from accounts WHERE acc_id < 100000000;
                                  QUERY PLAN                                   
-------------------------------------------------------------------------------
 Bitmap Heap Scan on accounts  (cost=23.76..90.83 rows=965 width=14)
   Recheck Cond: (acc_id < 100000000)
   ->  Bitmap Index Scan on accounts_pkey  (cost=0.00..23.52 rows=965 width=0)
         Index Cond: (acc_id < 100000000)
(4 rows)
```

1. Quants Bitmap Index Scan es fan? Per què?
```
Es fa 1 Bitmap Index Scan, per mirar la condició que es molt selectiva, però pot retornar molts accounts  de acc_id < 100000000
```
2. 
```
EXPLAIN SELECT * from accounts WHERE acc_id < 100000000 OR acc_id > 900000000;
                                     QUERY PLAN                                      
-------------------------------------------------------------------------------------
 Bitmap Heap Scan on accounts  (cost=48.14..132.42 rows=1857 width=14)
   Recheck Cond: ((acc_id < 100000000) OR (acc_id > 900000000))
   ->  BitmapOr  (cost=48.14..48.14 rows=1952 width=0)
         ->  Bitmap Index Scan on accounts_pkey  (cost=0.00..23.52 rows=965 width=0)
               Index Cond: (acc_id < 100000000)
         ->  Bitmap Index Scan on accounts_pkey  (cost=0.00..23.69 rows=987 width=0)
               Index Cond: (acc_id > 900000000)
(7 rows)
```
2. Quants Bitmap Index Scan es fan? Per què?
```
Es fa 2 Bitmap Index Scan, per mirar cada part de la condició OR de acc_id < 100000000 i la de acc_id > 900000000, ja que són independentx i necessiten index separats
```
3. 
```
EXPLAIN SELECT * from accounts WHERE acc_id > 100000000 AND acc_id < 900000000;
                          QUERY PLAN                          
--------------------------------------------------------------
 Seq Scan on accounts  (cost=0.00..205.00 rows=8046 width=14)
   Filter: ((acc_id > 100000000) AND (acc_id < 900000000))
(2 rows)
```
3. Quants Bitmap Index Scan es fan? Per què?
```
Es fa 0 Bitmap Index Scan, Perque ja un escaneig per la taula accounts
```

4. 
```
EXPLAIN SELECT * from accounts WHERE acc_id > 500000000 AND acc_id < 600000000;
                                  QUERY PLAN                                   
-------------------------------------------------------------------------------
 Bitmap Heap Scan on accounts  (cost=26.52..96.51 rows=999 width=14)
   Recheck Cond: ((acc_id > 500000000) AND (acc_id < 600000000))
   ->  Bitmap Index Scan on accounts_pkey  (cost=0.00..26.28 rows=999 width=0)
         Index Cond: ((acc_id > 500000000) AND (acc_id < 600000000))
(4 rows)
```
4. Quants Bitmap Index Scan es fan? Per què?
```
Es fa 1 Bitmap Index Scan,  per mirar la condició que es mes selectiva que l'anterior entre 500000000 i 600000000.
``` 
5. 
```
EXPLAIN SELECT type, sum(balance) FROM names n, owners o, accounts a WHERE n.nif=o.own_id AND n.name=o.own_name AND o.acc_id=a.acc_id AND own_name<'BIKA' GROUP BY type;
                                              QUERY PLAN                                               
-------------------------------------------------------------------------------------------------------
 GroupAggregate  (cost=405.29..405.31 rows=1 width=10)
   Group Key: a.type
   ->  Sort  (cost=405.29..405.30 rows=1 width=10)
         Sort Key: a.type
         ->  Nested Loop  (cost=0.56..405.28 rows=1 width=10)
               ->  Nested Loop  (cost=0.28..396.98 rows=1 width=4)
                     ->  Seq Scan on owners o  (cost=0.00..380.36 rows=2 width=22)
                           Filter: (own_name < 'BIKA'::text)
                     ->  Index Scan using names_name_key on names n  (cost=0.28..8.30 rows=1 width=18)
                           Index Cond: (name = o.own_name)
                           Filter: (o.own_id = nif)
               ->  Index Scan using accounts_pkey on accounts a  (cost=0.29..8.30 rows=1 width=14)
                     Index Cond: (acc_id = o.acc_id)
(13 rows)


=> EXPLAIN ANALYZE SELECT type, sum(balance) FROM names n, owners o, accounts a WHERE n.nif=o.own_id AND n.name=o.own_name AND o.acc_id=a.acc_id AND own_name<'BIKA' GROUP BY type;
QUERY PLAN                                                          
-----------------------------------------------------------------------------------------------------------------------------
 GroupAggregate  (cost=405.29..405.31 rows=1 width=10) (actual time=2.050..2.053 rows=0 loops=1)
   Group Key: a.type
   ->  Sort  (cost=405.29..405.30 rows=1 width=10) (actual time=2.049..2.051 rows=0 loops=1)
         Sort Key: a.type
         Sort Method: quicksort  Memory: 25kB
         ->  Nested Loop  (cost=0.56..405.28 rows=1 width=10) (actual time=2.045..2.046 rows=0 loops=1)
               ->  Nested Loop  (cost=0.28..396.98 rows=1 width=4) (actual time=2.044..2.045 rows=0 loops=1)
                     ->  Seq Scan on owners o  (cost=0.00..380.36 rows=2 width=22) (actual time=2.043..2.044 rows=0 loops=1)
                           Filter: (own_name < 'BIKA'::text)
                           Rows Removed by Filter: 20109
                     ->  Index Scan using names_name_key on names n  (cost=0.28..8.30 rows=1 width=18) (never executed)
                           Index Cond: (name = o.own_name)
                           Filter: (o.own_id = nif)
               ->  Index Scan using accounts_pkey on accounts a  (cost=0.29..8.30 rows=1 width=14) (never executed)
                     Index Cond: (acc_id = o.acc_id)
 Planning Time: 0.506 ms
 Execution Time: 2.088 ms
(17 rows)
```


5. Quina millora has fet per tal que el planificador de Postgres proposi una altre estratègia? Copia la comanda
```
CREATE INDEX index_name_name ON names (name);
CREATE INDEX index_owner_ownid ON owners (own_id);
CREATE INDEX index_onwer_ownname ON owners (own_name);
CREATE INDEX index_owner_accid ON owners (acc_id);
CREATE INDEX index_accounts_accid ON accounts (acc_id);
```

5. Els costos reals desprès del canvi han millorat respecte dels costos abans del canvi? Quant han millorat? Per què?
```
=> EXPLAIN ANALYZE SELECT type, sum(balance) FROM names n, owners o, accounts a WHERE n.nif=o.own_id AND n.name=o.own_name AND o.acc_id=a.acc_id AND own_name<'BIKA' GROUP BY type;
                                                                      QUERY PLAN                                                                       
-------------------------------------------------------------------------------------------------------------------------------------------------------
 GroupAggregate  (cost=24.93..24.95 rows=1 width=10) (actual time=0.007..0.008 rows=0 loops=1)
   Group Key: a.type
   ->  Sort  (cost=24.93..24.93 rows=1 width=10) (actual time=0.007..0.007 rows=0 loops=1)
         Sort Key: a.type
         Sort Method: quicksort  Memory: 25kB
         ->  Nested Loop  (cost=0.85..24.92 rows=1 width=10) (actual time=0.003..0.004 rows=0 loops=1)
               ->  Nested Loop  (cost=0.56..16.61 rows=1 width=4) (actual time=0.003..0.003 rows=0 loops=1)
                     ->  Index Scan using index_onwer_ownname on owners o  (cost=0.29..8.30 rows=1 width=22) (actual time=0.002..0.003 rows=0 loops=1)
                           Index Cond: (own_name < 'BIKA'::text)
                     ->  Index Scan using index_name_name on names n  (cost=0.28..8.30 rows=1 width=18) (never executed)
                           Index Cond: (name = o.own_name)
                           Filter: (o.own_id = nif)
               ->  Index Scan using index_accounts_accid on accounts a  (cost=0.29..8.30 rows=1 width=14) (never executed)
                     Index Cond: (acc_id = o.acc_id)
 Planning Time: 0.751 ms
 Execution Time: 0.038 ms
(16 rows)

=> EXPLAIN SELECT type, sum(balance) FROM names n, owners o, accounts a WHERE n.nif=o.own_id AND n.name=o.own_name AND o.acc_id=a.acc_id AND own_name<'BIKA' GROUP BY type;
                                                 QUERY PLAN                                                  
-------------------------------------------------------------------------------------------------------------
 GroupAggregate  (cost=24.93..24.95 rows=1 width=10)
   Group Key: a.type
   ->  Sort  (cost=24.93..24.93 rows=1 width=10)
         Sort Key: a.type
         ->  Nested Loop  (cost=0.85..24.92 rows=1 width=10)
               ->  Nested Loop  (cost=0.56..16.61 rows=1 width=4)
                     ->  Index Scan using index_onwer_ownname on owners o  (cost=0.29..8.30 rows=1 width=22)
                           Index Cond: (own_name < 'BIKA'::text)
                     ->  Index Scan using index_name_name on names n  (cost=0.28..8.30 rows=1 width=18)
                           Index Cond: (name = o.own_name)
                           Filter: (o.own_id = nif)
               ->  Index Scan using index_accounts_accid on accounts a  (cost=0.29..8.30 rows=1 width=14)
                     Index Cond: (acc_id = o.acc_id)
(13 rows)
```
```
Cost abans: 405.31 Cost després: 24.95 Reducció del cost: 405.31 - 24.95 = 380.36, Es fa una consulta més eficient ja que, els índexs permeten accedir ràpidament a les files rellevants i reduir el nombre de files que s'han de comprovar en els joins.  
```
6. Aquestes darreres preguntes les hauràs de respondre a partir de l'execució en el PostgreSQL del teu PC, 
doncs al no ser administrador d'ubiwan no pots modificar el fitxer postgresql.conf i per tant no pots modificar el valor del paràmetre log_min_duration_statement
```
EXPLAIN SELECT type, sum(balance) FROM names n, owners o, accounts a WHERE n.nif=o.own_id AND n.name=o.own_name AND o.acc_id=a.acc_id AND n.num<800 GROUP BY type;

EXPLAIN ANALYZE SELECT type, sum(balance) FROM names n, owners o, accounts a WHERE n.nif=o.own_id AND n.name=o.own_name AND o.acc_id=a.acc_id AND n.num<800 GROUP BY type;

Execution Time: 56.434 ms
log_min_duration_statement = 50
```

6. Quin valor has posat al paràmetre log_min_duration_statement del teu servidor Postgres? (en milisegons) (0 - 10000)
```
50
Execution Time: 56.434 ms 
log_min_duration_statement = 50
```
6. Copia la línia del fitxer de logs de Postgres a on ha quedat reflectit que la query ha trigat més de log_min_duration_statement milisegons
```
2024-05-25 20:57:29.880 CEST [5384] userdabd@dabd LOG:  duration: 51.199 ms  statement: EXPLAIN ANALYZE SELECT type, sum(balance) FROM names n, owners o, accounts a WHERE n.nif=o.own_id AND n.name=o.own_name AND o.acc_id=a.acc_id AND num<800 GROUP BY type;
```
6. Quina millora has fet per tal que el planificador de Postgres proposi una altre estratègia? Copia la comanda
og: 
```
EXPLAIN ANALYZE SELECT type, sum(balance) FROM names n, owners o, accounts a WHERE n.nif=o.own_id AND n.name=o.own_name AND o.acc_id=a.acc_id AND n.num<800 GROUP BY type;
Planning Time: 0.867 ms
Execution Time: 39.809 ms
```
millorada:
```
CREATE INDEX idx_name_nif ON names(nif);
CREATE INDEX idx_owners_ownid ON owners(own_id);
CREATE INDEX idx_owners_ownname ON owners(own_name);
CREATE INDEX idx_owners_accid ON owners(acc_id);
CREATE INDEX idx_accounts_accid ON accounts(acc_id);
CREATE INDEX idx_name_num ON names(num);
```
```
EXPLAIN ANALYZE SELECT type, sum(balance) FROM ( SELECT n.nif, n.name, n.num, o.own_id, o.own_name, o.acc_id FROM names n JOIN owners o ON n.nif = o.own_id AND n.name = o.own_name WHERE n.num < 800) AS filtered_data
JOIN accounts a ON filtered_data.acc_id = a.acc_id GROUP BY type;

QUERY PLAN                                                                      
------------------------------------------------------------------------------------------------------------------------------------------------------
 GroupAggregate  (cost=490.66..491.14 rows=3 width=10) (actual time=50.137..52.096 rows=3 loops=1)
   Group Key: a.type
   ->  Sort  (cost=490.66..490.81 rows=60 width=10) (actual time=49.180..50.067 rows=14267 loops=1)
         Sort Key: a.type
         Sort Method: quicksort  Memory: 1053kB
         ->  Nested Loop  (cost=34.34..488.89 rows=60 width=10) (actual time=0.465..43.868 rows=14267 loops=1)
               ->  Hash Join  (cost=34.06..469.72 rows=60 width=4) (actual time=0.451..13.034 rows=14267 loops=1)
                     Hash Cond: ((o.own_id = n.nif) AND (o.own_name = n.name))
                     ->  Seq Scan on owners o  (cost=0.00..330.09 rows=20109 width=22) (actual time=0.009..2.917 rows=20109 loops=1)
                     ->  Hash  (cost=22.08..22.08 rows=799 width=18) (actual time=0.430..0.431 rows=799 loops=1)
                           Buckets: 1024  Batches: 1  Memory Usage: 48kB
                           ->  Seq Scan on names n  (cost=0.00..22.08 rows=799 width=18) (actual time=0.008..0.211 rows=799 loops=1)
                                 Filter: (num < 800)
                                 Rows Removed by Filter: 327
               ->  Index Scan using idx_accounts_accid on accounts a  (cost=0.29..0.32 rows=1 width=14) (actual time=0.002..0.002 rows=1 loops=14267)
                     Index Cond: (acc_id = o.acc_id)
 Planning Time: 1.246 ms
 Execution Time: 52.275 ms
(18 rows)
```
6. Els costos reals desprès del canvi han millorat respecte dels costos abans del canvi? Quant han millorat?
```
Cost abans: 490.74 Cost després: 490.66  Reducció del cost:  490.74 - 490.66 = 0.08 
```

6. Explica el perquè de la pregunta anterior: El motiu per què ha millorat o per què no ha millorat en cas de que cap millora proposada no faci efecte (el planificador no canvia d'estratègia o els costos reals no es redueixen).
```
El cost de la consulta no ha millorat significativament perquè el planificador de PostgreSQL ja havia determinat que l'estratègia original era òptima. La creació de nous índexs no proporciona un avantatge probablement per la complexitat de la consulta.
```

