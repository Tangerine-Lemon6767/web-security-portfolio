import sqlite3 
conn = sqlite3 .connect ("AAA.db")
cursor = conn.cursor ()
username = input ("Username:")
password = input ("Password:")
query= f"select* from users where username ='{username}'and password ='{password}'"
print ("Query =", query)
cursor.execute("select * from users where username=? and password=?",(username,password))
result = cursor.fetchone()
if result:
     print("Login success!")
else:
     print("Login failed!") 
conn.close() 
       
 
