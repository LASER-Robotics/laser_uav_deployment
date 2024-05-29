# khadas setup

## In your desktop

### Configuring operating system

It is possible to install the operating system in two ways using the Khadas internal memory or using an external SD card.

### Using internal memory to storage OS

#### 1 - Download image and tools for burn image on board

In this first step we will format the board and put the Ubuntu 20 Linux distribution. 
To download the image and the tools to carry out this task, simply copy the following code and paste it into a terminal on your PC with Ubuntu {any version}.

``` sh
cd /tmp
echo "cd ~/Documents
mkdir setup_khadas_vim_os
cd setup_khadas_vim_os
wget https://dl.khadas.com/products/vim3/firmware/ubuntu/emmc/vim3-ubuntu-22.04-gnome-linux-5.15-fenix-1.6.3-240112-emmc.img.xz
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
burn-tool -v aml -b VIM3 -i ./vim3-ubuntu-22.04-gnome-linux-5.15-fenix-1.6.3-240112-emmc.img.xz" > run.sh && source run.sh
```
### Using SD card to storage OS

#### 1 - Download image

In this first step we will format the SD card and put the Ubuntu 20 Linux distribution. 
To download the image and the tools to carry out this task, simply copy the following code and paste it into a terminal on your PC with Ubuntu {any version}.

``` sh
cd /tmp
echo "cd ~/Documents
mkdir setup_khadas_vim_os
cd setup_khadas_vim_os
wget https://dl.khadas.com/products/vim3/firmware/ubuntu/generic/vim3-ubuntu-22.04-gnome-linux-6.1-fenix-1.4-221229.img.xz" > run.sh && source run.sh
```

#### 2 - Identify the name of your SD card in /dev {!!!!!!!!!! ATTENTION !!!!!!!!!!}

To do this, simply copy the code below into your terminal.

``` sh
ls /dev
```

Then insert your SD card into the computer and again enter the command in your terminal.
The new name that appears is the name of your SD card. Keep that name.

#### 3 - Burn image in SD card

Now let's burn the OS image onto the SD card, to do this just copy and paste the following code into the terminal.

``` sh
cd /tmp
echo "cd ~/Documents
cd setup_khadas_vim_os
sudo dd if=./vim3-ubuntu-22.04-gnome-linux-6.1-fenix-1.4-221229.img.xz of=/dev/{Name of your SD card in the /dev folder} bs=1M && sync" > run.sh && source run.sh
```

## Sending this package to khadas

First we will clone this repository and then we will send it via scp to khadas, to do this just copy and paste the following code into the terminal.

``` sh
cd /tmp
echo "mkdir ~/git
cd ~/git
git clone git@github.com:LASER-Robotics/laser_uav_deployment.git
scp ./laser_uav_deployment khadas@{change for khadas ip}:~/" run.sh && source run.sh
```

## In Khadas

Run the khadas deploy file and answer the questions for a successful configuration, to do this just copy and paste the following code into the terminal.

``` sh
cd ~/laser_uav_system/khadas/deploy.sh
```


