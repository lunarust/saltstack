#!/bin/bash

salt -N "alma" cmd.run 'yum list-security --security'

salt -N "alma" cmd.run 'yum -y update --nogpgcheck'
