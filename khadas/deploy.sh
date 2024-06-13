#!/bin/bash

mkdir ~/git
mv ~/laser_uav_system ~/git/

~/git/laser_uav_deployment/miscellaneous/computer_setup/configurate_uav_constants_in_bash.sh
source ~/.bashrc

~/git/laser_uav_deployment/miscellaneous/computer_setup/configurate_network.sh
~/git/laser_uav_deployment/miscellaneous/computer_setup/disable_hibernation.sh
~/git/laser_uav_deployment/miscellaneous/computer_setup/configurate_ssh_key.sh

cd ~/git
git clone git@github.com:LASER-Robotics/laser_uav_system.git
./laser_uav_system/install.sh

~/git/laser_uav_deployment/khadas/miscellaneous/uart_khadas_setup.sh
