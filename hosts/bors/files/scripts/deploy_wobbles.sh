#!/bin/bash
#===============================================================================
#         FILE: deploy_wobble.sh
#       AUTHOR: Celine H.
# ORGANIZATION: ---
#      VERSION: 0.0.1
#      COMMENT: This script is called by Salt via Jenkins, hence the use of switch user
#               Somehow I get
#===============================================================================
## array / list of mini app
declare -a arr=('flux2post' 'hazevents' 'wobblealert')
ROOTDIR=/home/rust/git/wobbles_hazards
cd /home/rust/git/wobbles_hazards && git pull

# echo "$TERM"
for i in "${arr[@]}"
do
   echo "############### Building & releasing $i"
   cd $ROOTDIR/$i
   #/bin/su -c "cd ${ROOTDIR}/$i/ && cargo build --release --quiet" - rust
   sudo -i -u rust sh -c "cd ${ROOTDIR}/$i/ && cargo build --release --quiet"
   cp target/release/$i /opt/scripts/

done

echo "############### Building the library"
/bin/su -c "cd ${ROOTDIR}/push_phone/ && cargo build --release" - rust
cd $ROOTDIR/push_phone
# cargo build --release

echo "Moving to scripts"
sudo cp target/debug/libpush_phone.rlib /opt/scripts/


sudo -i rust bash -c "cd /home/rust/git/wobbles_hazards/push_phone/ && cargo build --release --quiet"

RUSTUP_HOME=/opt/rust
export RUSTUP_HOME
CARGO_HOME=/opt/rust
export CARGO_HOME
curl https://sh.rustup.rs -sSf | sh -s -- -y --no-modify-path
