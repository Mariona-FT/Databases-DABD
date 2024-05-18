import sqlite3

def liquidar_interessos(db_path):
    conn = sqlite3.connect(db_path)
    cursor = conn.cursor()
    
    try:
        # Inicia transacció
        cursor.execute('BEGIN TRANSACTION;')
        
        #SUMA saldos abans de la liquidació
        cursor.execute("SELECT SUM(balance) FROM comptes;")
        suma_inicial = cursor.fetchone()[0]
        print(f"Suma total dels saldos abans de la liquidació: {suma_inicial:.2f} EUR")

        # trobar compte banc
        cursor.execute("SELECT acc_id, balance FROM comptes WHERE type = 'S' ORDER BY acc_id LIMIT 1;")
        bank_account = cursor.fetchone()
        bank_acc_id, bank_balance = bank_account
        
        # Trobar tots els comptes de tipus 'C' - llistat
        cursor.execute("SELECT acc_id, balance FROM comptes WHERE type = 'C';")
        c_accounts = cursor.fetchall()
        
        total_interests = 0
        for acc_id, balance in c_accounts: #llista dels comptes
            interest = round(balance * 0.01, 2) # 0.01 del compte + 2 decimals
            total_interests += interest
            # Actualitza compte C amb els seus interessos
            cursor.execute("UPDATE comptes SET balance = balance + ? WHERE acc_id = ?;", (interest, acc_id))
        
        # Actualitzar compte banc
        if bank_balance >= total_interests:
            cursor.execute("UPDATE comptes SET balance = balance - ? WHERE acc_id = ?;", (total_interests, bank_acc_id))
        else:
            raise ValueError("El banc no té suficients fons per cobrir els interessos.")
        
        # Calcula la suma dels saldos després de la liquidació
        cursor.execute("SELECT SUM(balance) FROM comptes;")
        suma_final = cursor.fetchone()[0]
        print(f"Suma total dels saldos després de la liquidació: {suma_final:.2f} EUR")

        # Verificar si sumes iguals incici // final
        if abs(suma_inicial - suma_final) > 0.01:
            raise Exception("La suma dels saldos abans i després de la liquidació no coincideixen.")

        # Commit de la transacció !per guardar en la bd
        conn.commit()
        print(f"Interessos liquidats correctament. Total d'interessos distribuïts: {total_interests:.2f} EUR")
        
    except Exception as e:
        conn.rollback()  # Rollback si error
        print(f"Error durant la liquidació d'interessos: {e}")
    finally:
        conn.close()

# Exemple d'ús:
liquidar_interessos('bigger.db')
