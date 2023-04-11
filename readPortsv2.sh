#!/bin/bash 

#Colours
greenColour="\e[0;32m\033[1m"
endColour="\033[0m\e[0m"
redColour="\e[0;31m\033[1m"
blueColour="\e[0;34m\033[1m"
yellowColour="\e[0;33m\033[1m"
purpleColour="\e[0;35m\033[1m"
turquoiseColour="\e[0;36m\033[1m"
grayColour="\e[0;37m\033[1m"

# Ctrl + c 

function ctrl_c(){
	echo -e "\n\n\t${redColour}[!]${endColour} ${grayColour}Saliendo...${endColour}\n\n"
	tput cnorm; exit 1 
}

trap ctrl_c SIGINT

# Help 

function help(){
	echo -e "\n\n\t${grayColour}Uso ${endColour}${yellowColour}----> ${endColour} ${purpleColour}$0${endColour} ${yellowColour}{ip_to_scan}${endColour}\n"
	echo -e "\t${yellowColour}(i)${endColour} ${grayColour}Ejemplo: ${endColour}${purpleColour}$0 ${endColour}${yellowColour}192.168.1.1${endColour}\n\n"
	tput cnorm; exit 0
}

# Exec 

function checkPort(){
	ip=$1 
	port=$2 

	(exec 3<> /dev/tcp/$ip/$port) 2>/dev/null
	
	if [ $? -eq 0 ]; then 
		echo -e "\t${yellowColour}(!)${endColour} ${grayColour}Puerto${endColour} ${yellowColour}$port${endColour} ${grayColour}abierto.${endColour}"
	fi

	exec 3<&- 
	exec 3>&-

}

function main(){
	
	tput civis # Ocultar el cursor 
	
	declare -a ports=( $(seq 1 65535) )
	ip=$1

	if [ ! $1 ]; then 
		help 
	else
		echo -e "\n\n\t${purpleColour}[+] ${endColour}${grayColour}Puertos del host${endColour} ${yellowColour}$ip${endColour}${grayColour}:${endColour}\n"
		for port in ${ports[@]}; do 
			checkPort $ip $port 	
		done 
	fi 

	wait 
	
	tput cnorm # Devolver el cursor 
}


main $1  
