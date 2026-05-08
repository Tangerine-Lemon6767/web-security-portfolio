from flask import Flask, request,render_template
import sqlite3
app = Flask(__name__)
def get_db():
    return sqlite3.connect("AAA.db")
@app.route("/", methods=["GET","POST"])
def login():
  if request.method=="POST":
   username = request.form["username"]
   password = request.form["password"]
   conn = get_db()
   cursor = conn.cursor()
   cursor.execute("select* from users where username=? and password=?",(username,password))
   user = cursor.fetchone()
   if user:
      return "Login success"
   else:
     return "Login failed" 
  return render_template("ABC.html")   
app.run(debug=True)      

