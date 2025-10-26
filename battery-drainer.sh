#!/bin/bash

echo "Remember to turn screen brightness all the way up and turn off display power management."
  
#battery drain script, for use in Kali

killall xscreensaver xfce4-screensaver xscreensaver-systemd
  
#stress test assumes 8 CPU's
stress -c 8 -t 10000

#move mouse every 10 seconds
for i in {1..1000}; do
	x=$(shuf -i 1-1000 -n 1)
	y=$(shuf -i 1-1000 -n 1)
 	echo "iteration $i"	
	echo "coordinates: $x,$y"
	xdotool mousemove $x $y
	echo "sleeping for 10 seconds..."
	sleep 10 
done
