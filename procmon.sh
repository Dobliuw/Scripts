#!/bin/bash 

# Ctrl + c

function ctrl_c(){
	echo -e "\ņ\n\t[!] Quiting...\n\n"
	tput cnorm; exit 1 
}

trap ctrl_c SIGINT 


old_process=$(ps -eo user,command)

tput civis 

while true; do 
	new_process=$(ps -eo user,command)
	diff <(echo "$old_process") <(echo "$new_process") | grep "[\>\<]" | grep -vE "kworker|procmon|command" 
	old_process=$new_process 
done 
