#!/usr/bin/python3
# Mariona Farré - DABD 

# instalar paquets: pip install PyMySQL
# Configurar la connexió en MYSQL depenen del teu user de ubiwan

from optparse import OptionParser
import pymysql

def do_query(c, q, n=None):
    if opt.show:
        print(f"Query is: {q} with values {n}")
    c.execute(q, n)

optp = OptionParser()
optp.add_option("-i", "--init", dest="init", action="store_true", default=False,
                help="create the table")
optp.add_option("-a", "--add", dest="add", action="store_true", default=False,
                help="add new pairs to table")
optp.add_option("-d", "--delete", dest="delete", action="store_true", default=False,
                help="delete an user")
optp.add_option("-l", "--list", dest="list", action="store_true", default=False,
                help="list all users")
optp.add_option("-s", "--show", dest="show", action="store_true", default=False,
                help="show queries")

(opt, args) = optp.parse_args()

# Configurar connexio amb MySQL
conn = pymysql.connect(host="ubiwan.epsevg.upc.edu", user="est_userubiw", password="dB.userubiw", database="est_userubiw")
c = conn.cursor()

tabname = "users"

if opt.init:
    print("Creating table " + tabname)
    try:
        do_query(c, f"CREATE TABLE {tabname} (username VARCHAR(255), passwd VARCHAR(255));") #posar limits en els texts
    except Exception as e:
        print("Table not created: ", e)
        conn.rollback()  # evitar error
        y = input("Try drop table first? [y]:")
        if y == 'y':
            do_query(c, f"DROP TABLE {tabname};")
            do_query(c, f"CREATE TABLE {tabname} (username VARCHAR(255), passwd VARCHAR(255));") #posar limits en els texts
    conn.commit()
elif opt.add:
    print("Adding further users, leave empty username to finish")
    while True:
        u = input("username: ")
        if not u:
            break
        p = input("passwd: ")
        do_query(c, f"INSERT INTO {tabname} (username, passwd) VALUES (%s, %s);", (u, p)) #guardar info parametitzada 
    conn.commit()
elif opt.delete:
    print("Deleting a user")
    u = input("username: ")
    # Primer, comprova si l'usuari existeix
    c.execute(f"SELECT * FROM {tabname} WHERE username=%s;", (u,))
    user = c.fetchone()
    if user:
        # Si l'usuari existeix, procedeix amb l'eliminació
        do_query(c, f"DELETE FROM {tabname} WHERE username=%s;", (u,))
        conn.commit()
        print("User deleted.")
    else:
        # Si l'usuari no existeix, mostra un missatge d'error
        print("Error: User not found.")
elif opt.list:
    print("Listing full table " + tabname + ":")
    do_query(c, f"SELECT * FROM {tabname};")
    for row in c.fetchall():
        print(f"User: {row[0]}, passwd: {row[1]}") #llistat tots els usuaris
else:
    print("Checking some user")
    u = input("username:")
    p = input("passwd:") 
    do_query(c, f"SELECT * FROM {tabname} WHERE username = %s AND passwd = %s;", (u, p)) #seleccionar la info de un usuari
    row = c.fetchone()
    if row:
        print(f"Access granted to user: {row[0]} via passwd: {row[1]}") #donar info del usuari que s'ha donat
    else:
        print("Access denied")

c.close()
conn.close()

