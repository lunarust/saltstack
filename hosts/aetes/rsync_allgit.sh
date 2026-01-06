#!/bin/bash
#===============================================================================
#         FILE: rsync_allgit.sh
#       AUTHOR: Celine
# ORGANIZATION: ---
#      VERSION: 0.0.1
#      CREATED: 24-11-2025
#         TODO:
#===============================================================================

DATE=$(date +"%Y-%m-%d_%H%M")
rsync -avzh  --delete --exclude target/ --exclude .git ~/git/ rust@helios.greece.local:~/bkp/
echo "$DATE rsync completed"
