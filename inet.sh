#!/bin/bash

#user must be root to run this
#if [ "$EUID" -ne 0 ]
#    then echo "Must be root to run this"
#    exit 1
#fi

interface="wlp3s0"

#ip link set $interface up
printf "Interface is up.\n"

#get pid of wpa_supplicant
wpa_pid="$(ps aux | pgrep wpa)"

#TODO: check for arguments like uni, home... and run respective wpa script
#check if it is running if it is, kill it
#-n returns if a var is set or not empty
if [ -n "$wpa_pid" ]; then
    #echo $wpa_pid
    printf "Wpa_supplicant running on %d\n" $dhcp_pid
    printf "killing %d\n" $wpa_pid
    #pkill $wpa_pid
else
    #let error="cant find wpa process"
    printf "no wpa running\n"
fi

#let user chose which script
#wpa_supplicant -i $interface -c /etc/wpa_supplcant/eduroam.conf

dhcp_pid="$(ps aux | pgrep dhcpcd)"

if [ -n "$dhcp_pid" ]; then
    printf "dhcpcd running on %d\n" $dhcp_pid
    #printf "killing dhdpcd\n"
    #pkill $dhcp_pid
else
    printf "starting dhcpcd on %s\n" $interface
    #dhcpcd $interface
fi




exit 0
