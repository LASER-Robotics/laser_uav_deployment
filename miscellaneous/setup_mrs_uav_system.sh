#!/bin/bash

./install_ros_noetic.sh

sudo curl -s --compressed -o /etc/ros/rosdep/sources.list.d/ctu-mrs-stable.list "https://ctu-mrs.github.io/ppa-stable/ctu-mrs-arm64.list"

set -e

trap 'last_command=$current_command; current_command=$BASH_COMMAND' DEBUG
trap 'echo "$0: \"${last_command}\" command failed with exit code $?"' ERR

echo "$0: Adding MRS Stable PPA repository"

sudo apt-get -y install curl gpg dpkg-dev

curl -s --compressed "https://ctu-mrs.github.io/ppa-stable/ctu-mrs.gpg" | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/ctu-mrs.gpg >/dev/null
sudo curl -s --compressed -o /etc/apt/sources.list.d/ctu-mrs-stable.list "https://ctu-mrs.github.io/ppa-stable/ctu-mrs-apt.list"
sudo curl -s --compressed -o /etc/apt/preferences.d/ctu-mrs-stable-preferences "https://ctu-mrs.github.io/ppa-stable/ctu-mrs-ppa-preferences.txt" 

sudo apt-get -y update

sudo rosdep init
rosdep update

echo "$0: Finished adding MRS Stable PPA repository"

sudo apt install ros-noetic-mrs-uav-system ros-noetic-mrs-uav-px4-api ros-noetic-mrs-uav-modules ros-noetic-mrs-hector-core ros-noetic-mrs-uav-deployment -y

echo $'\e[1;32mPlease configure the uav parameters in your bashrc :\e[0m\n' 

cd ~/git
git clone https://github.com/ctu-mrs/mrs_uav_development

if [ $(grep -c "/git/mrs_uav_development/shell_additions/shell_additions.sh" ~/.bashrc) -ne 1 ]; then
  source ~/git/mrs_uav_development/shell_additions/shell_additions.sh && echo -e "\n# source Shell additions\nsource ~/git/mrs_uav_development/shell_additions/shell_additions.sh\n" >> ~/.bashrc
fi

if [ $(grep -c "export UAV_TYPE=
export RUN_TYPE=
export UAV_NAME=
export UAV_MASS=
export WORLD_NAME=
export INITIAL_DISTURBANCE_X=
export INITIAL_DISTURBANCE_Y=
export OLD_PX4_FW=0" ~/.bashrc) -ne 1 ]; then
   echo -e "export UAV_TYPE=f330
export RUN_TYPE=realworld
export UAV_NAME=
export INITIAL_DISTURBANCE_X=0.0
export INITIAL_DISTURBANCE_Y=0.0
export OLD_PX4_FW=0" >> ~/.bashrc
fi

source ~/.bashrc

