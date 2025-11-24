#!/bin/bash

salt -N "debian" cmd.run 'apt list --upgradable | grep "\-security"'

salt -N "debian" cmd.run 'apt-get update && apt-get -y upgrade'
