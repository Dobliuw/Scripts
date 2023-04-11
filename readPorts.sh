#!/bin/bash 

# Colours
greenColour="\e[0;32m\033[1m"
endColour="\033[0m\e[0m"
redColour="\e[0;31m\033[1m"
blueColour="\e[0;34m\033[1m"
yellowColour="\e[0;33m\033[1m"
purpleColour="\e[0;35m\033[1m"
turquoiseColour="\e[0;36m\033[1m"
grayColour="\e[0;37m\033[1m"

# Ctrl + C 

function ctrl_c(){
	echo -e "\n\n\t${redColour}[!]${endColour} ${grayColour}Saliendo...${endColour}\n\n"
	exit 1
}

# Help 

function help(){
	echo -e "\n\n\t[!] Uso: $0 {target_ip}\n"
	echo -e "\tExample --> $0 192.168.1.1\n\n"
	exit 0  
}

# Exec 

function main(){
	ip=$1
	declare -a ports=()
	if [ ! $ip ]; then 
		help 
	else 
		for port in $(seq 1 65535); do 
			bash -c "echo '' > /dev/tcp/$ip/$port" 2>/dev/null && ports+=($port) 
		done
		length=${#ports[@]}
		if [ $length -gt 1 ]; then 
			echo -e "\n\n\tPuertos abiertos: "
			for port in ${ports[@]}; do 
			  echo -e "\t(!) ---> $port"
			done 
			echo -e "\n\n"
		fi 
	fi
}

trap ctrl_c SIGINT 

main $1

