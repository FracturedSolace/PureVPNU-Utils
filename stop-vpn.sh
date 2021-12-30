#!/bin/bash
#------------
#stop-vpn.sh
#------------
#This script stops a VPN server after making sure that sensitive programs are closed

#Check for super user privilleges
if [ "$EUID" != 0 ]
  then echo "This script must be run as root"
  exit
fi
	
#Make sure to disable transmission before reverting to normal IP
systemctl stop transmission-daemon

if [[ $? != 0 ]]
then
	echo ["$(tput setaf 1)"ERROR"$(tput setaf 7)]"] transmission-daemon was not shut down successfully, leaving VPN active
	exit 1
fi

killall openvpn &> /dev/null
