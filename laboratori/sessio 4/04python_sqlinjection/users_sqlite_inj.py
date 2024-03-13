#! /usr/bin/python3

from optparse import OptionParser
import sqlite3

def do_query(c, q):
    if opt.show:
        print("Query is: " + q)
    c.execute(q)

def do_script(c, q):
    if opt.show:
        print("Query is: " + q)
    c.executescript(q)

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

conn = sqlite3.connect("users.db")
c = conn.cursor()

tabname = "users"

if opt.init:
    print("Creating table "+tabname)
    try:
        do_query(c, "CREATE TABLE %s (username text, passwd text);" % tabname)
    except:
        print("Table not created")
        y = input("Try drop table first? [y]:")
        if y == 'y':
            "BUT NEVER CONSTRUCT A QUERY THAT WAY"
            do_query(c, "DROP TABLE %s;" % tabname)
            do_query(c, "CREATE TABLE %s (username text, passwd text);" % tabname)
    conn.commit()
elif opt.add:
    print("Adding further users, leave empty username to finish")
    while True:
        u = input("username: ")
        if not u:   
            break
        p = input("passwd: ")
        q = "INSERT INTO %s VALUES ('%s','%s');" % (tabname, u, p)
        do_script(c, q) # BUT NEVER CONSTRUCT A QUERY THAT WAY
    conn.commit()
elif opt.delete:
    print("Deleting an user")
    u = input("username: ")
    q = "DELETE FROM %s WHERE username='%s';" % (tabname, u)
    do_query(c, q) # BUT NEVER CONSTRUCT A QUERY THAT WAY
    conn.commit()
    if c.rowcount:
        print("User %s deleted." % u)
    else:
        print("User %s not found." % u)
elif opt.list:
    print("Listing full table "+tabname+":")
    do_query(c, "SELECT * FROM %s;" % tabname)
    for row in c:
        print("User: %s, passwd: %s" % (row[0], row[1]))
else:
    print("Checking some user")
    u = input("username:")
    p = input("passwd:")
    q = "SELECT * FROM %s WHERE username = '%s' AND passwd = '%s';" % (tabname, u, p)
    do_query(c, q) # BUT NEVER CONSTRUCT A QUERY THAT WAY
    row = c.fetchone()
    if row:
        print("Access granted to user: %s via passwd: %s" % (row[0], row[1]))
    else:
        print("Access denied")

c.close()
