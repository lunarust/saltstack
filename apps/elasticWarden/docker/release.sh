#!/bin/bash
#===============================================================================
#         FILE: release.sh
#       AUTHOR: Celine H.
#===============================================================================
cd /opt/elasticWarden
docker-compose pull
docker-compose down && docker-compose up -d
