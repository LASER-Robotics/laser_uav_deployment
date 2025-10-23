#!/bin/bash

echo "Configure network"

net_id="" 
[[ -t 0 ]] && { read -p $'\e[1;32mWhat is the name of your wifi network? :\e[0m\n' net_id ; }

net_pass="" 
[[ -t 0 ]] && { read -p $'\e[1;32mWhat is the password of your wifi network? :\e[0m\n' net_pass ; }

net_wifi_ip_fix=""
[[ -t 0 ]] && { read -p $'\e[1;32mWhat is the fixed IP you want to configure wifi? :\e[0m\n' net_wifi_ip_fix ; }

net_gateway=""
[[ -t 0 ]] && { read -p $'\e[1;32mWhat is the gateway you want to configure? :\e[0m\n' net_gateway ; }

net_eth_ip_fix=""
[[ -t 0 ]] && { read -p $'\e[1;32mWhat is the fixed IP you want to configure for ethernet? :\e[0m\n' net_eth_ip_fix ; }

cp ../../miscellaneous/netplan/01-netcfg.yaml /tmp/01-netcfg.yaml

sed -i 's/wifi_id/'"$net_id"'/g' /tmp/01-netcfg.yaml
sed -i 's/wifi_pass/'"$net_pass"'/g' /tmp/01-netcfg.yaml
sed -i 's/"wifi_ip"/'$net_wifi_ip_fix'/g' /tmp/01-netcfg.yaml
sed -i 's/"wifi_gateway"/'$net_gateway'/g' /tmp/01-netcfg.yaml
sed -i 's/"ethernet_ip"/'$net_eth_ip_fix'/g' /tmp/01-netcfg.yaml

sudo rm -r /etc/netplan/*
sudo mv /tmp/01-netcfg.yaml /etc/netplan/

sudo netplan apply

