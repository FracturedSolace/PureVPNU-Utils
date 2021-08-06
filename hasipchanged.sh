#!/bin/bash
#------------
#hasipchanged.sh
#------------
#This script checks currnt IP against last known region to ensure that the IP has actually changed after a VPN switch

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

#This should never be reached, but exists as a safety
exit 1