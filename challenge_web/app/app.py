from flask import Flask, render_template, request, redirect, url_for, session, g
import sqlite3
import hashlib

app = Flask(__name__)
app.secret_key = 'secret_key'

# Créer une base de données en mémoire (ou fichier si tu préfères)
def init_db():
    conn = sqlite3.connect(':memory:')  # Utilise ':memory:' pour une DB temporaire en mémoire
    c = conn.cursor()
    c.execute('''CREATE TABLE users (username TEXT, password TEXT, role TEXT)''')
    c.execute('''INSERT INTO users (username, password, role) VALUES ('user', ?, 'user')''', (hashlib.md5('password'.encode()).hexdigest(),))
    c.execute('''INSERT INTO users (username, password, role) VALUES ('admin', ?, 'admin')''', (hashlib.md5('adminpassword'.encode()).hexdigest(),))
    conn.commit()
    return conn

# Connexion à la DB
def get_db():
    if not hasattr(g, 'sqlite_db'):
        g.sqlite_db = init_db()
    return g.sqlite_db

@app.route('/')
def home():
    if 'username' in session:
        return redirect(url_for('dashboard'))
    return redirect(url_for('login'))

@app.route('/login', methods=['GET', 'POST'])
def login():
    if request.method == 'POST':
        username = request.form['username']
        password = request.form['password']

        # Injection SQL vulnérable ici
        conn = get_db()
        c = conn.cursor()
        query = f"SELECT * FROM users WHERE username = '{username}' AND password = '{password}'"
        c.execute(query)
        user = c.fetchone()

        if user:
            session['username'] = username
            session['role'] = user[2]  # Stocke le rôle dans la session
            return redirect(url_for('dashboard'))
        return "Login failed!"

    return render_template('login.html')

@app.route('/admin')
def admin_panel():
    if 'username' not in session:
        return redirect(url_for('login'))
    
    # Vulnérabilité d'escalation de privilèges : le paramètre role n'est pas vérifié
    # et est directement injecté dans la requête SQL
    role = request.args.get('role', 'user')
    conn = get_db()
    c = conn.cursor()
    # Pas de vérification du rôle, ce qui permet une escalade de privilèges directe
    query = f"UPDATE users SET role = '{role}' WHERE username = '{session['username']}'"
    c.execute(query)
    conn.commit()
    
    # Mise à jour de la session avec le nouveau rôle
    session['role'] = role
    return redirect(url_for('dashboard'))

@app.route('/dashboard')
def dashboard():
    if 'username' not in session:
        return redirect(url_for('login'))

    if session.get('role') == 'admin':
        return render_template('admin.html', flag="FLAG{s1mpl3_sql_injecti0n}")
    
    return f"Hello, {session['username']}! You are a {session.get('role', 'user')}."

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=5000)
