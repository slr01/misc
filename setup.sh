#!/bin/bash
###Script to configure a fresh install of Xubuntu
sudo apt install curl
curl -s https://packagecloud.io/install/repositories/ookla/speedtest-cli/script.deb.sh | sudo bash
sudo apt install speedtest
sudo apt install iperf3 -y
sudo apt install conky -y
sudo mv /etc/conky/conky.conf /etc/conky/conky.conf.old
sudo wget -P /etc/conky https://raw.githubusercontent.com/slr01/misc/main/conky.conf

###Work around for the bug related to the HSUART DMA kernel module on Cherry Trail CPUs
sudo echo '\nblacklist dw_dmac_core\ninstall dw_dmac /bin/true\ninstall dw_dmac_core /bin/true' >> /etc/modprobe.d/blacklist.conf
sudo update-initramfs -u

###For Use As A Headless Display
sudo echo '\nvkms' >> /etc/modules-load.d/modules.conf

###Turn off Hibernate/Sleep, Disable Swap And Delete Swap File
sudo systemctl mask sleep.target suspend.target hibernate.target hybrid-sleep.target
sudo swapoff -a
sudo sed -i.bak '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab
sudo rm /swapfile

###Install Log2Ram (and resize Journal use)
echo "deb [signed-by=/usr/share/keyrings/azlux-archive-keyring.gpg] http://packages.azlux.fr/debian/ bullseye main" | sudo tee /etc/apt/sources.list.d/azlux.list
sudo wget -O /usr/share/keyrings/azlux-archive-keyring.gpg  https://azlux.fr/repo.gpg
sudo apt update
sudo apt install log2ram
sudo echo '\nSystemMaxUse=20M' >> /etc/systemd/journald.conf
sudo systemctl restart systemd-journald

###Remove Libre Office and Thunderbird
sudo apt remove --purge libreoffice* thunderbird*
sudo apt clean
sudo apt autoremove
