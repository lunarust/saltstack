#!/bin/bash
#===============================================================================
#         FILE: release.sh
#       AUTHOR: Celine H.
#===============================================================================
cd /opt/flashcards

docker-compose down

docker-compose pull

docker-compose up -d
