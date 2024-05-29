#!/bin/bash

old_user=$(whoami)

sudo adduser "$UAV_NAME"
sudo usermod -aG sudo "$UAV_NAME"
sudo groupmod -n "$UAV_NAME" "$old_user"
