#!/bin/bash

function ctrl_c(){
	echo -e "\n\n\t[!] Quiting...\n\n"
	exit 1
}

trap ctrl_c INT

ip=$1

if [ $ip ]; then
	/usr/bin/seq 1 65535 | /usr/bin/xargs -P 500 -I {} /usr/bin/proxychains -q /usr/bin/nmap -sT -Pn -p{} --open -n -v $ip 2>&1 | /usr/bin/grep -i "tcp open"
else
	echo -e "\n\n\t[!] USAGE: $0 {target_ip}\n\n"
fi
