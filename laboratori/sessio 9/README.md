## Instruccions utilitzades en la sessió 9:

instalar postgre LINUX: ``$sudo apt-get install postgresql postgresql-client``

Inicialment es crea usuari: ``postgres``

Per administrar i configurar PostgreSQL
```
$ sudo su postgres
$ psql
\l
\q
```
Fora de psql podem crear usuaris addicionals amb contrasenya i una base de dades inicial que li pertanyi:
```
# createuser --pwprompt --createdb --no-createrole --no-superuser nom_usuari
$ createuser --pwprompt --createdb --no-createrole --no-superuser userdabd
..contrasenya
# createdb nom_base_de_dades -O nom_usuari
$ createdb dabd -O userdabd
```
Configurar l'accés a postgres:

Si es vol accedir amb l'usuari anterior amb la contrasenya entrada, cal modificar el fitxer:
``/etc/postgresql/12/main/pg_hba.conf (cal canviar el número 12 segons la versió de PostgreSQL que tenim)`` canviant aquesta línia:
```
# "local" is for Unix domain socket connections only
local   all             all                                     peer

per
# "local" is for Unix domain socket connections only
local   all             all                                     md5
```

Si també volem accedir des d'algunes màquines de l'exterior faríem (aquest exemple permet accedir a la mateixa màquina, a les màquines de la xarxa local 192.168.0.x i màquines de 62.57.200.x):
```
# IPv4 local connections:
host    all         all         127.0.0.1/32          md5
host    all         all         192.168.0.0 255.255.255.0 md5
host    all         all         62.57.200.0 255.255.248.0 md5
```
Desprès caldrà rearrancar el servidor PostgreSQL:
``$ sudo service postgresql restart``

igual com: ``$ sudo /etc/init.d/postgresql restart``

Ara ja podrem treballar amb un usuari i una base de dades concreta:

**Preguntes** 

1. Quants MB de RAM té ubiwan?
```
	cat /proc/meminfo
	MemTotal:        8136104 kB
```
2. Quants MB de la RAM d'ubiwan dedicaries a PostgreSQL?
```	
    2048 MB el 25%
```
3. Quantes CPUs té ubiwan?
```
	cat /proc/cpuinfo | grep processor | wc -l
	8
```
4. Quin tipus de disc té ubiwan?
```
	 cat /sys/block/sda/queue/rotational
	1
	1 vol dir HDD, 0 indica SSD
	No s'ha seleccionat
	X HDD
	SSD
```
5. Quina versió de PostgreSQL té ubiwan?
```
	psql --version
	psql (PostgreSQL) 12.18 (Ubuntu 12.18-0ubuntu0.20.04.1)
```
6. Quantes connexions simultànies màximes estan permeses a PostgreSQL?
```
	 grep max_connections /etc/postgresql/*/main/postgresql.conf
	max_connections = 100			# (change requires restart)
```
7. Canviaries el valor del paràmetre work_mem?
```
	No s'ha seleccionat
	No
	X Sí
	Sí, considerant que el valor predeterminat pot no estar optimitzat per a la càrrega de treball específica o la quantitat de memòria disponible.
```
8. En cas que sí, quin valor proposes pel paràmetre work_mem?
```
	16 MB per a work_mem. 
```
Això pot ajustar-se segons la monitorització del rendiment i el consum actual de memòria.

9. Canviaries el valor del paràmetre maintenance_work_mem?
```
	No s'ha seleccionat
	No
	X Sí
	Sí, especialment si el sistema maneja operacions de manteniment regulars com VACUUM que 
poden beneficiar-se d'una major quantitat de memòria.
```
10. En cas que sí, quin valor proposes pel paràmetre maintenance_work_mem?
```
	256 MB per a maintenance_work_mem, que ajudaria a accelerar les operacions de manteniment sense impactar el rendiment general.
```
11. Canviaries el valor del paràmetre effective_cache_size?
```
	No s'ha seleccionat
	No
	X Sí
	Sí, per ajudar a optimitzar el rendiment de les consultes ajustant millor l'estimació de la memòria disponible per a caching.
```
12. En cas que sí, quin valor proposes pel paràmetre effective_cache_size?
```
	4 GB si tenim unes 3GB pel Postgre
```	
13. Canviaries el valor del paràmetre random_page_cost?
```
	No s'ha seleccionat
	X No
	Sí
```
14. En cas que sí, quin valor proposes pel paràmetre random_page_cost?
```
    -
```
15. Canviaries el valor del paràmetre max_worker_processes?
```
	No s'ha seleccionat
	No
	X Sí
```
16. En cas que sí, quin valor proposes pel paràmetre max_worker_processes?
```
    8 com el numero de les CPUs
```
