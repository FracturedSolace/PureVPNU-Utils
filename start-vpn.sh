#!/bin/bash
#------------
#start-vpn.sh
#------------
#This script starts a purevpn server and ensures that the user's IP address has changed

login_file_location="/home/fracturedsolace/purevpn/login.txt"
server_list_directory="/home/fracturedsolace/purevpn/TCP"
default_server="de2-ovpn-tcp.ovpn"

timeout_time=8

#Check for super user privilleges
if [[ "$EUID" != 0 ]]
  then echo "This script must be run as root"
  exit
fi

#Check that servers directory exists
if [[ ! -d "${server_list_directory}" ]]
then
	echo [ERROR] Directory does not exist: ${server_list_directory} 
	echo ...did you install the purevpn servers to the correct directory?
	exit 1
fi

#Check if the user specified a server to use
if [[ $# == 0 ]]
then
	echo [Info] No server specified, using "${default_server}"
	selected_server="${server_list_directory}/${default_server}"
else
	#If the specified parameter is a valid (OVPN) file, then use it as selected server
	if [[ -f $1 ]]
	then
		selected_server="${1}"
	#Otherwise, try to append the parameter to default server directory to see if it resides there
	elif [[ -f "${server_list_directory}/${1}" ]]
	then
		selected_server="${server_list_directory}/${1}"
	#fi
	#Finally, throw an error if we couldn't find the file anywhere
	else
		echo ["$(tput setaf 1)"ERROR"$(tput setaf 7)]"] Could not find server "${1}" in "${server_list_directory}"
		exit 1
	fi
fi
	
#Initiate the VPN on another thread
openvpn --config "${selected_server}" --auth-user-pass "${login_file_location}" &

#Wait for our timeout to give the VPN a chance to set up
sleep "${timeout_time}"

#Check that the IP change was successful (assumes changing to non-native region IP is intended)
hasipchanged.sh &> /dev/null

if [[ $? != 0 ]]
then
	echo ["$(tput setaf 1)"ERROR"$(tput setaf 7)"] IP does not appear to have changed regions. Aborting.
	exit 1
else
	echo ["$(tput setaf 2)"SUCCESS"$(tput setaf 7)"] IP is now "$(dig +short myip.opendns.com @resolver1.opendns.com)"
fi
