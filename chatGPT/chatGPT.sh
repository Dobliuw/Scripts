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
  echo -e "\n\n\n\n\t${redColour}(!) Quiting...${endColour}\n\n"
  exit 1 
}

trap ctrl_c INT 

# Global variables
url="https://api.openai.com/v1/chat/completions"
api_key="apiKey" 
# Program

function main(){
  while true; do
    read -p "$(echo -e "\n\n${purpleColour}(!)${endColour} ${grayColour}Insert your${endColour} ${purpleColour}question: ${endColour}")" question 
    payload='{
     "model": "gpt-3.5-turbo",
     "messages": [{"role": "system", "content": "Eres un analista de cyberseguridad orientada a red team"}, {"role": "user", "content": "'"$question"'"}]
    }'
    response=$(curl -s -H "Content-Type: application/json" -H "Authorization: Bearer $api_key" -d "$payload" https://api.openai.com/v1/chat/completions)  
    echo -e "\n\n${greenColour}[i] ChatGPT${endColour}: "
    echo -e $response | grep content -A 100 | grep -vE '},|"finish_reason"|}],|"usage":{|"prompt_tokens":|"completion_tokens":|"total_tokens":|}|"usage":|"content":' | tr -d '",'
  done 
}

 main 
