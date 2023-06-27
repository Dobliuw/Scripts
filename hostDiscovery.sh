#!/bin/bash

function ctrl_c(){
	echo -e "\n\n\t[!] Quiting...\n\n"
	exit 1
}

trap ctrl_c SIGINT

for host in $(seq 1 254); do
	timeout 1 bash -c "ping -c 1 10.10.0.$host" &>/dev/null && echo "[!] Host 10.10.0.$host ACTIVE" &
done; wait
