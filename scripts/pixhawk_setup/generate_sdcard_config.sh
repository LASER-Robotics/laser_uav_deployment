#!/bin/bash

rm -r ../../miscellaneous/pixhawk/sdcard_config/etc/*

touch ../../miscellaneous/pixhawk/sdcard_config/etc/extras.txt
touch ../../miscellaneous/pixhawk/sdcard_config/etc/config.txt

echo "uxrce_dds_client start -t serial -d /dev/ttyS3 -b 2000000 -n $UAV_NAME" >> ../../miscellaneous/pixhawk/sdcard_config/etc/extras.txt
echo "usleep 100000" >> ../../miscellaneous/pixhawk/sdcard_config/etc/extras.txt

echo "param set UXRCE_DDS_DOM_ID $ROS_DOMAIN_ID" >> ../../miscellaneous/pixhawk/sdcard_config/etc/config.txt
echo "param set UXRCE_DDS_KEY 1" >> ../../miscellaneous/pixhawk/sdcard_config/etc/config.txt
echo "param set SER_TEL2_BAUD 2000000" >> ../../miscellaneous/pixhawk/sdcard_config/etc/config.txt
echo "param set DSHOT_TEL_CFG 103" >> ../../miscellaneous/pixhawk/sdcard_config/etc/config.txt
echo "param set MAV0_CONFIG 101" >> ../../miscellaneous/pixhawk/sdcard_config/etc/config.txt
echo "param set MAV1_CONFIG 103" >> ../../miscellaneous/pixhawk/sdcard_config/etc/config.txt
echo "param set MAV2_CONFIG 0" >> ../../miscellaneous/pixhawk/sdcard_config/etc/config.txt

echo "Paste and copy etc folder into sd card, the etc folder can be find in \"/laser_uav_deployment/miscellaneous/pixhawk/sdcard_config\""
