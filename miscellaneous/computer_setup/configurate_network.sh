echo "Configure network"

net_id="" 
[[ -t 0 ]] && { read -p $'\e[1;32mWhat is the name of your wifi network? :\e[0m\n' net_id ; }

net_pass="" 
[[ -t 0 ]] && { read -p $'\e[1;32mWhat is the password of your wifi network? :\e[0m\n' net_pass ; }

net_fix_ip=""
[[ -t 0 ]] && { read -p $'\e[1;32mWhat is the fixed IP you want to configure? :\e[0m\n' net_fix_ip ; }

nmcli device wifi connect "$net_id" password "$net_pass"
nmcli con mod "$net_id" ipv4.addresses "$net_fix_ip"
nmcli con mod "$net_id" ipv4.dns "8.8.8.8"
nmcli con mod "$net_id" ipv4.method manual

