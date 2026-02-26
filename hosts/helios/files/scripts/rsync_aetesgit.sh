#!/bin/bash
#===============================================================================
#         FILE: rsync_aetesgit.sh
#       AUTHOR: Celine
# ORGANIZATION: ---
#      VERSION: 0.0.1
#         TODO:
#===============================================================================

DATE=$(date +"%Y-%m-%d_%H%M")
su rust -c 'rsync -avzh  --delete --exclude target/ --exclude .git rust@aetes.greece.local:/home/rust/git/ /home/rust/bkp/'
echo "$DATE rsync completed"
