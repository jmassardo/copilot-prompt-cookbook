import sqlite3

def get_user_by_id(user_id):
    conn = sqlite3.connect('database.db')
    cursor = conn.cursor()
    cursor.execute(f"SELECT display_name FROM users WHERE id = {user_id}")
    user = cursor.fetchone()
    conn.close()
    return user