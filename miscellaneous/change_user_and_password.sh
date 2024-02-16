resp=""

[[ -t 0 ]] && { read -p $'\e[1;32mWhich uav is this (please choose a name from this template: uav<number>) :\e[0m\n' resp ; }

old_user=$(whoami)

sudo usermod -l "$resp" "$old_user" 
sudo groupmod -n "$resp" "$old_user" 

sudo usermod -d /home/"$resp" -m "$resp"

echo $'\e[1;32mChanging password\e[0m\n'

sudo -i

echo $'\e[1;32mPlease put the username in the password\e[0m\n'
passwd "$resp"
