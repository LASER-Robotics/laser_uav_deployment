echo "Configure uart overlay gpio"

sudo rm -r /boot/dtb/amlogic/kvim3.dtb.overlay.env

sudo touch /boot/dtb/amlogic/kvim3.dtb.overlay.env
sudo echo "fdt_overlays=uart3" >> /boot/dtb/amlogic/kvim3.dtb.overlay.env

echo "Please reboot for activate the configuration"
