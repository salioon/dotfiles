#!/usr/bin/env bash

notify-send "Cargando la Lista Wifi..."
# Get a list of available wifi connections and morph it into a nice-looking list
wifi_list=$(nmcli --fields "SECURITY,SSID" device wifi list | sed 1d | sed 's/  */ /g' | sed -E "s/WPA*.?\S/ /g" | sed "s/^--/ /g" | sed "s/  //g" | sed "/--/d")

connected=$(nmcli -fields WIFI g)
if [[ "$connected" =~ "enabled" ]]; then
	toggle="睊  Apagar Wi-Fi"
elif [[ "$connected" =~ "disabled" ]]; then
	toggle="直  Encender Wi-Fi"
fi

# Use rofi to select wifi network
chosen_network=$(echo -e "$toggle\n$wifi_list" | uniq -u | rofi -dmenu -i -selected-row 1 -p "Wi-Fi SSID: " )
# Get name of connection
chosen_id=$(echo "${chosen_network:3}" | xargs)

if [ "$chosen_network" = "" ]; then
	exit
elif [ "$chosen_network" = "直  Encender Wi-Fi" ]; then
	nmcli radio wifi on
elif [ "$chosen_network" = "睊  Apagar Wi-Fi" ]; then
	nmcli radio wifi off
else
	# Message to show when connection is activated successfully
	success_message="Ahora estas conectado a la red Wi-Fi \"$chosen_id\"."
	# Get saved connections
	saved_connections=$(nmcli -g NAME connection)
	if [[ $(echo "$saved_connections" | grep -w "$chosen_id") = "$chosen_id" ]]; then
		nmcli connection up id "$chosen_id" | grep "Exito" && notify-send "Conexion establecida" "$success_message"
	else
		if [[ "$chosen_network" =~ "" ]]; then
			wifi_password=$(rofi -dmenu -p "Password: " )
		fi
		nmcli device wifi connect "$chosen_id" password "$wifi_password" | grep "Exito" && notify-send "Conexion Establecida" "$success_message"
	fi
fi
