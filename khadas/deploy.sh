../../miscellaneous/computer_setup/configurate_uav_constants_in_bash.sh
source ~/.bashrc
../miscellaneous/add_uav_user.sh
../../miscellaneous/computer_setup/configurate_network.sh
../../miscellaneous/computer_setup/disable_hibernation.sh
../../miscellaneous/computer_setup/configurate_ssh_key.sh

cd ~/git
git clone git@github.com:LASER-Robotics/laser_uav_system.git
./laser_uav_system/install.sh

../miscellaneous/uart_khadas_setup.sh
