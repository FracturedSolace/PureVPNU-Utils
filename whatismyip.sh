#!/bin/bash
#------------
#whatismyip.sh
#------------
#Quickly returns users external IP address

echo "$(dig +short myip.opendns.com @resolver1.opendns.com)"