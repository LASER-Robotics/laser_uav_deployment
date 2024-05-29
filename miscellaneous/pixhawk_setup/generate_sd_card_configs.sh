#!/bin/bash

mkdir etc

cd etc
rm -r *

touch config.txt
touch extras.txt

resp="" 
[[ -t 0 ]] && { read -p $'\e[1;32mWhat the uav name? :\e[0m\n' resp ; }

echo "uxrce_dds_client start -t serial -d /dev/ttyS3 -b 921600 -n $resp" >> ./extras.txt

echo "param set-default UXRCE_DDS_CFG 102" >> ./config.txt
echo "param set-default UXRCE_DDS_DOM_ID 200" >> ./config.txt
echo "param set-default SER_TEL2_BAUD 921600" >> ./config.txt
echo "param set-default DSHOT_TEL_CFG 103" >> ./config.txt
echo "param set-default MAV0_CONFIG 101" >> ./config.txt
echo "param set-default MAV1_CONFIG 103" >> ./config.txt
echo "param set-default MAV2_CONFIG 0" >> ./config.txt

echo "Paste and copy etc folder into sd card"
