#!/usr/bin/python3 
import openai, os, sys, signal 
from dotenv import load_dotenv

# Variables de entorno

load_dotenv()

api_key = os.getenv("API_KEY")

openai.api_key = api_key

# Ctrl + c 

def ctrl_c(frame, sig):
    print("\n\n\t[!] Saliendo...")
    sys.exit(1)

signal.signal(signal.SIGINT, ctrl_c)

# Programa 

def main(): 
    messages=[]
    context = {"role": "system", "content": "Eres un asistente de cyberseguridad orientada a red team"}
    messages.append(context)
    while True:
        userQuestion=input("\n\t[!] Consulta: ")
        messages.append({"role": "user", "content": userQuestion})
        response = openai.ChatCompletion.create(model="gpt-3.5-turbo", messages=messages)
        print(f"\n\n\t{response.choices[0].message.content}")


if __name__ == "__main__":
    main()



