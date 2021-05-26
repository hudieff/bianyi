#!/bin/bash

cd openwrt
sed -i "s/#KERNEL_VERSION/KERNEL_VERSION/" make.env
#sed -i '2,10 s/\(#\)\(.*\)/\2/' make.env
OLD=$(grep \+o\" make.env)
NEW=$(grep \+\" make.env)
echo $OLD
echo $NEW
cp make.env makesfe.env
sed -i "s/$NEW/#$NEW/" make.env
sed -i "s/$OLD/#$OLD/" makesfe.env
sed -i "s/SFE_FLAG=.*/SFE_FLAG=1/" makesfe.env
sed -i "s/FLOWOFFLOAD_FLAG=.*/FLOWOFFLOAD_FLAG=0/" makesfe.env
#sync the kernel version
KV=$(find /opt/kernel/ -name "boot*+o.tar.gz" | awk -F '[-.]' '{print $2"."$3"."$4"-"$5"-"$6}')
KVS=$(find /opt/kernel/ -name "boot*+.tar.gz" | awk -F '[-.]' '{print $2"."$3"."$4"-"$5"-"$6}')
sed -i "s/^KERNEL_VERSION.*/KERNEL_VERSION=\"$KV\"/" make.env
sed -i "s/^KERNEL_VERSION.*/KERNEL_VERSION=\"$KVS\"/" makesfe.env

for F in *.sh ; do cp $F ${F%.sh}_sfe.sh;done
find ./* -maxdepth 1 -path "*_sfe.sh" | xargs -i sed -i 's/make\.env/makesfe\.env/g' {}
echo "mk_files respawned."
