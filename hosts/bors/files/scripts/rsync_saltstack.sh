#!/bin/bash
#===============================================================================
#         FILE: rsync_saltstack.sh
#       AUTHOR: Celine
# ORGANIZATION: ---
#      VERSION: 0.0.1
#         TODO:
#===============================================================================

DATE=$(date +"%Y-%m-%d_%H%M")
su rust -c 'rsync -avzh rust@aetes.greece.local:/home/rust/git/saltstack/ /srv/saltstack/'
echo "$DATE rsync completed"
