#!/bin/bash
#===============================================================================
#         FILE: rsync_aetesgit.sh
#       AUTHOR: Celine
# ORGANIZATION: ---
#      VERSION: 0.0.1
#         TODO:
#===============================================================================

DATE=$(date +"%Y-%m-%d_%H%M")
su rust -c 'rsync -avzh  --delete /opt/jenkins/home/  rust@tanit.greece.local:/home/rust/jenkins_backup/'
echo "$DATE rsync completed"
