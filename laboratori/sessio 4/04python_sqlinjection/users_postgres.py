#!/usr/bin/python3
# Mariona Farré - DABD 

# instalar paquets: pip install psycopg2-binary
# Configurar la connexió en POSTGE depenen del teu user de ubiwan

from optparse import OptionParser
import psycopg2
from psycopg2 import sql

def do_query(c, q, n=()):
    if opt.show:
        print("Query is: " + q.as_string(conn) + " with values " + str(n))
    c.execute(q, n)

optp = OptionParser()
optp.add_option("-i", "--init", dest="init", action="store_true", default=False,
                help="create the table")
optp.add_option("-a", "--add", dest="add", action="store_true", default=False,
                help = "add new pairs to table")
optp.add_option("-d", "--delete", dest="delete", action="store_true", default=False,
                help = "delete an user")
optp.add_option("-l", "--list", dest="list", action="store_true", default=False,
                help = "list all users")
optp.add_option("-s", "--show", dest="show", action="store_true", default=False,
                help = "show queries")

(opt, args) = optp.parse_args()

# Configurar connexio amb MySQL
conn = psycopg2.connect(host="ubiwan.epsevg.upc.edu", user="est_userubiw", password="dB.userubiw", database="est_userubiw")
c = conn.cursor()

tabname = "users"

if opt.init:
    print("Creating table " + tabname)
    try:
        do_query(c, sql.SQL("CREATE TABLE {} (username text, passwd text);").format(sql.Identifier(tabname))) #crear taula
    except Exception as e:
        print("Table not created: ", e)
        conn.rollback()  # evitar error        
        y = input("Try drop table first? [y]:")
        if y == 'y':
            do_query(c, sql.SQL("DROP TABLE {};").format(sql.Identifier(tabname))) #borrar taula si aquesta existeix 
            do_query(c, sql.SQL("CREATE TABLE {} (username text, passwd text);").format(sql.Identifier(tabname))) # crear taula users 
    conn.commit()
elif opt.add:
    print("Adding further users, leave empty username to finish")
    while True:
        u = input("username: ")
        if not u:
            break
        p = input("passwd: ")

        do_query(c, sql.SQL("INSERT INTO {} VALUES (%s, %s);").format(sql.Identifier(tabname)), (u, p)) #Guardar user utilitzant espai parametitzat - postgre %s
    conn.commit()
elif opt.delete:
    print("Deleting an user")
    u = input("username: ") 
    do_query(c, sql.SQL("DELETE FROM {} WHERE username=%s;").format(sql.Identifier(tabname)), (u,)) #delete usuari si aquest existeix
    conn.commit()
    if c.rowcount:
        print("User %s deleted." % u)
    else:
        print("User %s not found." % u)
elif opt.list:
    print("Listing full table " + tabname + ":")
    do_query(c, sql.SQL("SELECT * FROM {};").format(sql.Identifier(tabname)))  # retornar tota la llista d'usuauari
    for row in c:
        print("User: %s, passwd: %s" % (row[0], row[1])) #print llista dels usuaris
else:
    print("Checking some user")
    u = input("username:")
    p = input("passwd:")
    do_query(c, sql.SQL("SELECT * FROM {} WHERE username = %s AND passwd = %s;").format(sql.Identifier(tabname)), (u, p)) #retornar info d'un usuari 
    row = c.fetchone()
    if row:
        print("Access granted to user: %s via passwd: %s" % (row[0], row[1]))
    else:
        print("Access denied")

c.close()
conn.close()
