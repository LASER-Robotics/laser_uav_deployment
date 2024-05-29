#!/bin/bash

resp=""
[[ -t 0 ]] && { read -p $'\e[1;32mWhich uav is this (please choose a name from this template: uav<number>) :\e[0m\n' resp ; }

old_user=$(whoami)

sudo adduser "$resp"
sudo usermod -aG sudo "$resp"
sudo groupmod -n "$resp" "$old_user"

cd /home/"$resp"
sudo mkdir git

sudo mv /home/"$old_user"/laser_uav_deployment /home/"$resp"/git/
