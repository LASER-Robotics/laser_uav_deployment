#!/bin/bash

rm -r ../../miscellaneous/fcu_configs/sdcard_config/etc/*

touch ../../miscellaneous/fcu_configs/sdcard_config/etc/extras.txt
touch ../../miscellaneous/fcu_configs/sdcard_config/etc/config.txt

echo "uxrce_dds_client start -t serial -d /dev/ttyS3 -b 2000000 -n $UAV_NAME" >> ../../miscellaneous/fcu_configs/sdcard_config/etc/extras.txt
echo "usleep 100000" >> ../../miscellaneous/fcu_configs/sdcard_config/etc/extras.txt

echo "param set UXRCE_DDS_DOM_ID $ROS_DOMAIN_ID" >> ../../miscellaneous/fcu_configs/sdcard_config/etc/config.txt
echo "param set UXRCE_DDS_KEY 1" >> ../../miscellaneous/fcu_configs/sdcard_config/etc/config.txt
echo "param set SER_TEL1_BAUD 0" >> ../../miscellaneous/fcu_configs/sdcard_config/etc/config.txt
echo "param set SER_TEL2_BAUD 2000000" >> ../../miscellaneous/fcu_configs/sdcard_config/etc/config.txt
echo "param set DSHOT_TEL_CFG 0" >> ../../miscellaneous/fcu_configs/sdcard_config/etc/config.txt
echo "param set DSHOT_BIDIR_EN 1" >> ../../miscellaneous/fcu_configs/sdcard_config/etc/config.txt
echo "param set MAV_0_CONFIG 101" >> ../../miscellaneous/fcu_configs/sdcard_config/etc/config.txt
echo "param set MAV_1_CONFIG 103" >> ../../miscellaneous/fcu_configs/sdcard_config/etc/config.txt
echo "param set MAV_2_CONFIG 0" >> ../../miscellaneous/fcu_configs/sdcard_config/etc/config.txt

echo "Paste and copy etc folder into sd card, the etc folder can be find in \"/laser_uav_deployment/miscellaneous/fcu_configs/sdcard_config\""
