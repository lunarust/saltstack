#!/bin/bash
#===============================================================================
#         FILE: deploy_wobble.sh
#       AUTHOR: Celine H.
# ORGANIZATION: ---
#      VERSION: 0.0.1
#===============================================================================
## array / list of mini app
declare -a arr=('flux2post' 'hazevents' 'wobblealert')
ROOTDIR=/home/rust/git/wobbles_hazards
cd /home/rust/git/wobbles_hazards
git pull

for i in "${arr[@]}"
do
   echo "############### Building & releasing $i"
   cd $ROOTDIR/$i
   cargo build --release
   sudo cp target/release/$i /opt/scripts/

done

echo "############### Building the library"
cd $ROOTDIR/push_phone
cargo build --release

echo "Moving to scripts"
sudo cp target/debug/libpush_phone.rlib /opt/scripts/
