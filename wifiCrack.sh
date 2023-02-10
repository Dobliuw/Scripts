#!/bin/bash

function wifiCrack(){
    interface=$1
  #verbose=$2
    if [[ $EUID -ne 0 ]]; then 
    echo "\n\n\t${redColour}Necesita ejecutarse como sudo ツ${endColour}\n\n"   
  else
    exist=$(/usr/sbin/ifconfig | grep $interface)
      if [ "$exist" ]; then
          /usr/sbin/ifconfig $interface down &>/dev/null
          /usr/sbin/airmon-ng start $interface &>/dev/null
          /usr/sbin/airmon-ng check kill &>/dev/null
          interface=$(/usr/sbin/iw dev | /usr/bin/grep monitor -C 5 | /usr/bin/grep Interface | /usr/bin/awk '{print $2}')
    [[ "$verbose" == "-v" ]] && echo -e "\n${purpleColour}[*]${endColour} ${grayColour}Interfaz${endColour} ${purpleColour}$interface${endColour} ${grayColour}levantada en mod
o monitor.${endColour} \n"
    [[ "$verbose" == "-v" ]] && echo -e "\n${purpleColour}[!]${endColour} ${grayColour}Proceso${endColour} ${purpleColour}wpa_suplicant${endColour} ${grayColour}matado.${endCo
lour}\n"
          /usr/bin/macchanger --mac="00:20:91:da:af:91" $interface &>/dev/null
      echo -e "\n${purpleColour}[*]${endColour} ${grayColour}Mac de la interfaz ${endColour}${purpleColour}$interface${endColour}${grayColour} cambiada a ----->${endColour} ${
purpleColour}00:20:91:da:af:91${endColour}\n"
          /usr/sbin/ifconfig $interface up &>/dev/null
          echo -e "\n${purpleColour}[i]${endColour} ${grayColour}Interfaz${endColour} ${purpleColour}$interface${endColour} ${grayColour}en modo monitor ON.${endColour}\n"
      else
          echo -e "\n${redColour}[!]${endColour} ${grayColour}No se reconoce la interfaz${endColour} ${redColour}$interface${endColour}\n" 
      fi
  fi
}
