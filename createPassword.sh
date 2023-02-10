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

# CTRL + C
function ctrl_c(){
  echo -e "\n\n${redColour}[!]${endColour} ${grayColour}Quiting...${endColour}\n\n"
  exit 1 
}

# CREATE PASSWORD
function createPassword(){
  read -p "$(echo -e "\n\n${purpleColour}[*]${endColour} ${grayColour}Insert your${endColour} ${purpleColour}length${endColour} ${grayColour}password:${endColour} ")" length
  read -p "$(echo -e "\n${purpleColour}[*]${endColour} ${grayColour}Insert${endColour} ${purpleColour}CAPITALS letters${endColour} ${greenColour}y${endColour}${grayColour}/${endColour}${redColour}n${endColour}${grayColour}:${endColour} ")" capital
  read -p "$(echo -e "\n${purpleColour}[*]${endColour} ${grayColour}Insert${endColour} ${purpleColour}numbers${endColour} ${greenColour}y${endColour}${grayColour}/${endColour}${redColour}n${endColour}${grayColour}:${endColour} ")" number
  read -p "$(echo -e "\n${purpleColour}[*]${endColour} ${grayColour}Insert${endColour} ${purpleColour}symbols${endColour} ${greenColour}y${endColour}${grayColour}/${endColour}${redColour}n${endColour}${grayColour}:${endColour} \n\n")" symbol
  
  declare -a characters=($(seq 97 122))

  [[ "$capital" == "y" ]] && characters+=($(seq 65 90))
  [[ "$number" == "y" ]] && characters+=($(seq 48 58))
  [[ "$symbol" == "y" ]] && characters+=($(for i in $(seq 33 46); do [[ ! "$i" -eq 34 ]] && [[ ! "$i" -eq 39 ]] && echo $i; done))
  
  password=""
  
  for num in $(seq 1 $length); do
    password+=$(printf "\x$(printf %x $(echo ${characters[$(/usr/bin/shuf -i 1-${#characters[@]} -n 1)]}))") 
  done
  
  echo -e "\n\n\t${purpleColour}[!]${endColour} ${grayColour}Here is your new password:${endColour} ${purpleColour}$password${endColour}\n\n"
  echo -e "$password" | xclip -sel clip
  exit 0 
}


trap ctrl_c INT 


createPassword

