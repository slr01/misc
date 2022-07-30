from scapy.all import *
import time,datetime
import os

def detect_deauth_attack(pkt):
	if pkt.haslayer(Dot11Deauth):
		time=datetime.datetime.today()
		a= ' [ ' +  str(time)+ ' ] '+  ' DeAuth detected against AP: ' +   str(pkt.addr2).swapcase()    
		print(a)
		
os.system("printf '\e]2;DeAuth Detector\a'")
sniff(iface="wlan1",prn=detect_deauth_attack,count=0)
