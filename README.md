# khadas vim setup

## In your desktop

### Configuring operating system

#### 1 - Download image and tools for burn image on board

In this first step we will format the board and put the Ubuntu 20 Linux distribution. 
To download the image and the tools to carry out this task, simply copy the following code and paste it into a terminal on your PC with Ubuntu {any version}

``` sh
cd /tmp
echo "cd ~/Documents
mkdir setup_khadas_vim_os
cd setup_khadas_vim_os
wget https://dl.khadas.com/products/vim3/firmware/ubuntu/emmc/vim3-ubuntu-20.04-gnome-linux-4.9-fenix-1.5-230425-emmc.img.xz
sudo apt-get install libusb-dev git parted
git clone https://github.com/khadas/utils
cd utils
sudo ./INSTALL" > run.sh && source run.sh
```

#### 2 - Power on Board in upgrade mode

  1. Power on VIM3.
  2. Long press the POWER key without releasing it.
  3. Short press the Reset key and release it.
  4. Count for 2 to 3 seconds, then release the POWER key to enter into Upgrade Mode. You will see the sys-led turn ON when you’ve entered Upgrade Mode.

You can check if it worked by seeing if Ubuntu recognized your card with the following command:

```sh
lsusb | grep Amlogic
```

The output should contain something like: {Bus 003 Device 073: ID 1b8e:c004 Amlogic, Inc. DNL}.  
If it didn't work, repeat this section.  

#### 3 - Burn the image to the board

With your board in upgrade mode, simply copy the following code into your terminal and the image will start to be burned onto the board.

``` sh
cd /tmp
echo "cd ~/Documents/setup_khadas_vim_os
burn-tool -v aml -b VIM3 -i ./vim3-ubuntu-20.04-gnome-linux-4.9-fenix-1.5-230425-emmc.img.xz" > run.sh && source run.sh
```

## In khadas vim

### Configuring network

#### Ethernet connection

For connection via ethernet cable, the connection is made in a plug and play way.  

#### Wifi connection

For a wifi connection use the next command line in your terminal:

``` sh
nmcli device wifi connect <wirelles network name> password <network password>
```

From now on it is assumed that you managed to connect Ubuntu to the board and now it is necessary that you clone this repository. To do this, copy the next code and paste it into a terminal.  

``` sh
cd /tmp
echo "cd ~/
mkdir git
cd git
sudo apt install git
git clone git@github.com:LASER-Robotics/khadas_vim_setup.git" > run.sh && source run.sh
```


