#!/bin/bash
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


cd /srv/saltstack/
git pull
salt 'rasppi*' state.highstate \ saltenv=salt -l debug

echo "Checking if we need to restart the service"
[[ "$1" == "YES" ]] && systemctl restart salt-master
