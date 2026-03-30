#!/bin/bash
#===============================================================================
#         FILE: saveme.sh
#       AUTHOR: Celine H.
#      COMMENT: Let's save our important stuff someplace...
#===============================================================================

echo ".. KeepassX"
su rust -c 'scp rust@aetes.greece.local:/home/rust/Downloads/kee_db_fornorwegianblue.kdbx rust@helios.greece.local:/opt/backup/'

echo ".. At some stage... DB?"


echo ".. Anyway, dear hooman, bye now ヾ(^_^)"
