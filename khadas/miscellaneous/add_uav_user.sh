#!/bin/bash

resp=""
[[ -t 0 ]] && { read -p $'\e[1;32mWhich uav is this (please choose a name from this template: uav<number>) :\e[0m\n' resp ; }

old_user=$(whoami)

sudo adduser "$resp"
sudo usermod -aG sudo "$resp"
sudo groupmod -n "$resp" "$old_user"

sudo rm -r /etc/hostname
sudo touch /etc/hostname
sudo echo "$resp" > /etc/hostname

sudo mkdir /home/"$resp"/git

sudo mv /home/"$old_user"/laser_uav_deployment /home/"$resp"/git/laser_uav_deployment
