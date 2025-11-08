#!/bin/bash
expected=1
current=$#

if [[ "${current}" -lt "${expected}" ]];
then
  echo "
  -------------------
  An error occurred,
  Not enough or incorrect arguments supplied
  Ex: $0 'nodename'
  -------------------"
  echo $(( $current >= $expected ? $current : $expected ))
  exit 1
fi


node=$1
cd /srv/saltstack/
#git pull


if [ "${2}" == "YES" ]; then
echo "***** Running full OS Update for ${node}"
  salt "${node}" cmd.run 'yum list-security --security'

  salt "${node}" pkg.clean_metadata
  salt "${node}" cmd.run 'yum -y update --nogpgcheck'
fi
echo "***** Running base refresh for ${node}"


salt "${node}" state.highstate \ saltenv=base


echo "Be polite and say bye..."
