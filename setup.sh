#!/bin/bash
###Script to configure a fresh install of Xubuntu
sudo apt install curl
curl -s https://packagecloud.io/install/repositories/ookla/speedtest-cli/script.deb.sh | sudo bash
sudo apt install speedtest
sudo apt install iperf3 -y
sudo apt install conky -y
sudo mv /etc/conky/conky.conf /etc/conky/conky.conf.old
sudo wget -P /etc/conky https://raw.githubusercontent.com/slr01/misc/main/conky.conf

###Remove Libre Office and Thunderbird
sudo apt remove --purge libreoffice* thunderbird* -y
sudo apt clean
sudo apt autoremove

###Work around for the bug related to the HSUART DMA kernel module on Cherry Trail CPUs
sudo echo '\nblacklist dw_dmac_core\ninstall dw_dmac /bin/true\ninstall dw_dmac_core /bin/true' >> /etc/modprobe.d/blacklist.conf
sudo update-initramfs -u

###For Use As A Headless Display
sudo echo '\nvkms' >> /etc/modules-load.d/modules.conf
