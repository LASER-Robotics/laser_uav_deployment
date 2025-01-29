#!/bin/bash

echo "Configure network"

net_id="" 
[[ -t 0 ]] && { read -p $'\e[1;32mWhat is the name of your wifi network? :\e[0m\n' net_id ; }

net_pass="" 
[[ -t 0 ]] && { read -p $'\e[1;32mWhat is the password of your wifi network? :\e[0m\n' net_pass ; }

net_fix_ip=""
[[ -t 0 ]] && { read -p $'\e[1;32mWhat is the fixed IP you want to configure? :\e[0m\n' net_fix_ip ; }

net_fix_gateway=""
[[ -t 0 ]] && { read -p $'\e[1;32mWhat is the fixed IP you want to configure? :\e[0m\n' net_fix_gateway ; }

sudo nmcli device wifi connect "$net_id" password "$net_pass"
sudo nmcli con mod "$net_id" ipv4.addresses "$net_fix_ip"
sudo nmcli con mod "$net_id" ipv4.gateway "$net_fix_gateway"
sudo nmcli con mod "$net_id" ipv4.dns "8.8.8.8"
sudo nmcli con mod "$net_id" ipv4.method manual

