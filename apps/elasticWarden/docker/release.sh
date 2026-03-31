#!/bin/bash
#===============================================================================
#         FILE: release.sh
#       AUTHOR: Celine H.
#===============================================================================
cd /opt/elasticWarden

docker-compose down

docker-compose pull

docker-compose up -d
