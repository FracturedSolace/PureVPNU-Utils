#!/bin/bash
#------------
#start-torrent.sh
#------------
#This script ensures that the transmission-daemon is running, checks the IP for safety, and then adds a specified torrent

#Check that IP is safe (not in the normal region)
hasipchanged.sh &> /dev/null

if [[ $? != 0 ]]
then
	echo ["$(tput setaf 1)"ERROR"$(tput setaf 7)"] IP is not currently safe
	exit 1
fi

#Check that a transmission daemon is running
systemctl status transmission-daemon &> /dev/null

if [[ $? != 0 ]]
then
	echo ["$(tput setaf 1)"ERROR"$(tput setaf 7)"] No transmission daemon is currently running.
	echo Try \"systemctl start transmission-daemon\"
	exit 2
fi

#Check if the user actually provided a magnet link
if [[ $# < 1 ]]
then
	echo ["$(tput setaf 1)"ERROR"$(tput setaf 7)"] No magnet link provided
	exit 3
fi

#Finally, go ahead and add the specified
transmission-remote -a "${1}"

#Return exit code 0 if transmission-remote was successful
if [[ $? == 0 ]]
then
	exit 0
else
	exit 4
fi
