#!/bin/bash

echo "Configure git and add ssh key on github"

resp="" 
[[ -t 0 ]] && { read -p $'\e[1;32mWhat is your github account name? :\e[0m\n' resp ; }

git config --global user.name "$resp"

resp="" 
[[ -t 0 ]] && { read -p $'\e[1;32mWhat is your github account email? :\e[0m\n' resp ; }

git config --global user.email "$resp"

ssh-keygen -t rsa -b 4096 -C "$resp"
eval $(ssh-agent -s)
ssh-add ~/.ssh/id_rsa
cat ~/.ssh/id_rsa.pub

[[ -t 0 ]] && { read -p $'\e[1;32mAfter copying and pasting the key above into your github account, press enter :\e[0m\n' ; }
