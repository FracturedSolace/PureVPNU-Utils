#!/bin/bash
#------------
#hasipchanged.sh
#------------
#This script checks currnt IP against last known region to ensure that the IP has actually changed after a VPN switch

if ! command -v geoiplookup &> /dev/null
then
	echo ["$(tput setaf 1)"ERROR"$(tput setaf 7)"] geoiplookup does not appear to be installed
	echo   try pacman -Sy geoip
	exit 1
fi

if ! command -v dig &> /dev/null
then
	echo ["$(tput setaf 1)"ERROR"$(tput setaf 7)"] dig does not appear to be installed
	echo   try pacman -Sy dnsutils
	exit 1
fi

new_ip="$(dig +short myip.opendns.com @resolver1.opendns.com)"
new_region="$(geoiplookup ${new_ip})"

original_region="GeoIP Country Edition: US, United States"

if [[ $new_region == $original_region ]]
then
	echo ["$(tput setaf 1)"FAIL"$(tput setaf 7)"] Current region did not change from "${original_region}"
	exit 1
else
	echo ["$(tput setaf 2)"SUCCESS"$(tput setaf 7)"] Current region changed from "${original_region}" to "${new_region}"
	echo [INFO] Current IP Address is "${new_ip}"
	exit 0
fi

#This should never be reached, but exists as a safety against returning 0 on failure
exit 1