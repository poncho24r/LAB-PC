#!/bin/bash
#
echo "La fecha es: "
date
    echo "---------------------------"
    echo "   Menu Principal"
    echo "---------------------------"
    echo "1. Detectar equipos activos en la red"
    echo "2. Detectar puertos activos"
    echo "3. Información General"
    echo "4. Exit"
read -p "Elige una opción: " c
case $c in
        1) echo "Equipos activos en la red:"
function is_alive_ping() { 
  ping -c 1 $1 > /dev/null 2>&1 
  [ $? -eq 0 ] && echo "Node with IP: $i is up." 
} 
for i in 192.168.1.{1..255} 
do 
  is_alive_ping $i & disown 
done;;

        2)echo "Puertos activos:"
if [ $# -eq 0 ]
then
	echo "Modo de uso: nombre archivo +  [IP]"
	echo "Ejemplo: nombre archivo + 192.168.1.19"
else
	echo "Favor de esperar mientras se escanean los primeros 1024 puertos..."
	nc -nvz $1 1-1024 > ${1}.txt 2>&1
	echo "Tu escaneo ha finalizado"
	echo "Podrás revisar tus resultados en el archivo: "${1}.txt
fi;;


        3)echo "Información general:"

	echo "Tu usuario es:"
		whoami

        echo "Tu host es:"
                hostname

	echo "Tu sistema operativo es:"
	if type -t wevtutil &> /dev/null
	then
    		OS=MSWin
	elif type -t scutil &> /dev/null
	then
  		OS=macOS
	else
   		OS=Linux
	fi
	echo $OS;;

        4) echo "Hasta luego!"; exit 0;;
esac
