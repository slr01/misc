#!/bin/bash
###Script to configure a fresh install of Xubuntu

wget -P ~/Pictures https://github.com/slr01/misc/raw/main/zen.jpg
sudo apt install curl
curl -s https://packagecloud.io/install/repositories/ookla/speedtest-cli/script.deb.sh | sudo bash
sudo apt install speedtest
sudo apt install iperf3 -y
sudo apt install conky -y
sudo mv /etc/conky/conky.conf /etc/conky/conky.conf.old
sudo wget -P /etc/conky https://raw.githubusercontent.com/slr01/misc/main/conky.conf
