#copy this to a .sh file and run with admin priveledges(sudo x.sh) on the bridge link
 
#stop network manager to make the mesh network work
sudo service network-manager stop
 
#configure the wlan interface to operate with mtus of 1532(batman requires it) and turn enc off to ensure it works
sudo ifconfig wlan0 down
sudo ifconfig wlan0 mtu 1532
sudo iwconfig wlan0 enc off
 
#add the interface to the ad-hoc network - or create it.
sudo iwconfig wlan0 mode ad-hoc essid DUCTN ap 02:12:34:56:78:9A channel 1
 
#load the module up
sudo modprobe batman-adv
 
#add wlan0 to the batman-adv virtual interface(so it can communicate with other batman-adv nodes)
sudo batctl if add wlan0
sudo ifconfig wlan0 up
sudo ifconfig bat0 up
#sudo ifconfig wlan0 192.168.0.2
sudo ifconfig bat0 10.42.43.2
#sudo route add default gw 192.168.0.3 netmask 255.255.255.0
sudo route add default gw 10.42.43.3 netmask 255.0.0.0
#make the bridge linking the batman-adv virtual interface to the ethernet port
#sudo brctl addbr bridge-link
#sudo brctl addif bridge-link bat0
 
#get the ip address for the bridge from the dhcp server
#sudo dhclient bridge-link
 
#show ip address for debug purposes
ifconfig|grep Bcast
#ping 192.168.0.3