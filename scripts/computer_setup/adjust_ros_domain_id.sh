#!/bin/bash

if [[ $UAV_NAME =~ ([0-9]+)$ ]]; then
  uav_number="${BASH_REMATCH[1]}"
fi

sed -i.bak -E "s/^(\s*(export\s+)?ROS_DOMAIN_ID\s*=\s*).*$/\1$uav_number/" ~/.bashrc
