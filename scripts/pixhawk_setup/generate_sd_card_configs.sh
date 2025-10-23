#!/bin/bash

rm -r ../../miscellaneous/pixhawk/sdcard_config/etc/*

touch ../../miscellaneous/pixhawk/sdcard_config/etc/extras.txt
touch ../../miscellaneous/pixhawk/sdcard_config/etc/config.txt

echo "uxrce_dds_client start -t serial -d /dev/ttyS3 -b 921600 -n $UAV_NAME" >> ../../miscellaneous/pixhawk/sdcard_config/etc/extras.txt

echo "param set-default UXRCE_DDS_CFG 102" >> ../../miscellaneous/pixhawk/sdcard_config/etc/config.txt
echo "param set-default UXRCE_DDS_DOM_ID $ROS_DOMAIN_ID" >> ../../miscellaneous/pixhawk/sdcard_config/etc/config.txt
echo "param set-default SER_TEL2_BAUD 921600" >> ../../miscellaneous/pixhawk/sdcard_config/etc/config.txt
echo "param set-default DSHOT_TEL_CFG 103" >> ../../miscellaneous/pixhawk/sdcard_config/etc/config.txt
echo "param set-default MAV0_CONFIG 101" >> ../../miscellaneous/pixhawk/sdcard_config/etc/config.txt
echo "param set-default MAV1_CONFIG 103" >> ../../miscellaneous/pixhawk/sdcard_config/etc/config.txt
echo "param set-default MAV2_CONFIG 0" >> ../../miscellaneous/pixhawk/sdcard_config/etc/config.txt

echo "Paste and copy etc folder into sd card, the etc folder can be find in \"/laser_uav_deployment/miscellaneous/pixhawk/sdcard_config\""
