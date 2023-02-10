#!/usr/bin/python3
import random, sys, signal, subprocess

def ctrl_c(sig, frame):
    print("\n\n[!] Quiting...\n")
    sys.exit(1)


signal.signal(signal.SIGINT, ctrl_c)


def check(length, password, characters, rangeChar):
    someoneChar = [chr(n) for n in rangeChar]
    check = False

    for i in someoneChar:
        if i in password:
            check = True

    if not check:
        password = list(password)
        password[random.randint(0, length + 1)] = random.choice(someoneChar)
        return "".join(password)
    else:
        return password


def run(length=8, capital=False, number=False, symbol=False, save=False, path=""):
    
    characters = list(range(97, 123))
    
    if capital:
        capitalsList = list(range(65, 91))
        characters = characters + capitalsList

    if number:
        numbersList = list(range(48, 58))
        characters = characters + numbersList

    if symbol:
        symbolsList = [num for num in range(33, 47) if num not in (34, 39)]
        characters = characters + symbolsList

    password = ''

    for n in range(1, length + 1):
        password += chr(random.choice([int(s) for s in characters]))

    if capital:
        password = check(length, password, characters, capitalsList) 
   
    if number:
        password = check(length, password, characters, numbersList)

    if symbol:
        password = check(length, password, characters, symbolsList)

    subprocess.Popen([f"echo \"{password}\" | xclip -sel clip"], shell=True)
    print(f"\n\n[!] Your new password generated: {password}\n")
    print("----------------------------------------------------------------------")

    if(save):
        with open(f"{path}/HERE.txt", "x", encoding="utf-8") as f:
            f.write(f"""
                    Thank you to used my script! I hope that help you to keep more safe your acounts!
                    
                    [!] Remember, this option is just for practique more python, it isn't recommended to save passwords in files...
                    But take ----> {password}

                    Att. <Dobliuw/>
                    """)

    return print(f"\n\t[i] Your password was copied to the clipboard (Ctrl + v). \n\n")

if __name__ == "__main__":
    try:
        length = int(input("\n\n\t[*] Insert your length password: "))
        capital = input("\t[*] Insert CAPITALS letters y/n: ")
        numbers = input("\t[*] Insert numbers y/n: ")
        symbols = input("\t[*] Insert symbols y/n: ")
        save = input("\t\n[!] Do you want to save the password? y/n: ")
        path = ""

        if(length < 8):
            raise ValueError("\n\n[!] Please insert a length password grater than 8\n\n")
        
        if(save == "y"):
            path = input("\n\n[!] Insert your path to save the file: ") 
        else:
            save = False
                
        length = length if length != "" else 8
        capital = True if capital == "y" else False
        numbers = True if numbers == "y" else False
        symbols = True if symbols == "y" else False

        run(length, capital, numbers, symbols, save, )

    except ValueError as ve:
        print(ve)
