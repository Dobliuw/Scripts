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

#function ctrl_c(){
#    echo -e "\n\n\t${redColour}[!]${endColour} ${grayColour}Saliendo...${endColour}\n
#\n"
#    exit 1
#}

#trap ctrl_c SIGINT 

# Help 

function help(){
    echo -e "\n\n\t${grayColour}Uso ${endColour}${yellowColour}----> ${endColour} ${purpleColour}$0${endColour} ${yellowColour}{interfaz}${endColour}\n"
    echo -e "\t${yellowColour}(i)${endColour} ${grayColour}Ejemplo: ${endColour}${purpleColour}$0 ${endColour}${yellowColour}eth0/ens33/etc${endColour}\n\n"
    tput cnorm; exit 0
}

function getHosts(){
	
	interfaz=$1

	if [[ $EUID -ne 0 ]]; then
		echo -e "\n\n\t${redColour}Necesita ejecutarse como sudo :)${endColour}\n\n"
		exit 1
	fi
	
	if [ ! $interfaz ]; then 
		help 
	else 
		declare -a hosts=( $(/usr/sbin/arp-scan -I $interfaz --localnet | /usr/bin/grep -oP '\d{1,3}.\d{1,3}.\d{1,3}.\d{1,3}' | /usr/bin/sort -u | /usr/bin/tr '\n' ' ' | /usr/bin/xargs ) ) 
		for host in ${hosts[@]}; do 
			./readPortsv2.sh $host 
		done 
	fi
}


getHosts $1
