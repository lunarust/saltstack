#!/bin/bash

if [[ $EUID -ne 0 ]]; then
  echo "Please run this script with root user"
  exit 1
fi

if [ $# -ne 1 ]
then
  echo "
  -------------------
  An error occurred,
  Not enough or incorrect arguments supplied
  Ex: $0 'YES|NO'
  -------------------"
  exit 1
fi


me=`basename "$0"`
today=$(date "+%Y-%m-%dT%H:%M")
echo "starting script $me $today"


cd /srv/saltstack/
#git pull
salt 'aetes*' state.highstate \ saltenv=salt

echo "Checking if we need to restart the service"
[[ "$1" == "YES" ]] && systemctl restart salt-master

echo "Be polite and say bye..."
