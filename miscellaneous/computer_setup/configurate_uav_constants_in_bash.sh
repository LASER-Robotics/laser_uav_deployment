if [ $(grep -c "UAV_NAME" ~/.bashrc) -ne 1 ]; then
  resp=""
  [[ -t 0 ]] && { read -p $'\e[1;32mWhich uav is this (please choose a name from this template: uav<number>) :\e[0m\n' resp ; }
  echo -e "\n# uav identifier\n export UAV_NAME=$resp" >> ~/.bashrc
fi

echo -e "\n# identifies that it is being deployed on the real drone\n export REAL_UAV=True" >> ~/.bashrc


