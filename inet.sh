#!/bin/zsh

#user must be root to run this
if [ "$EUID" -ne 0 ]
    then echo "Must be root to run this"
    exit 1
fi
if [ -z "$1" ]; then
    printf "specify the network\n"
    exit 1
fi

#lrz support and start vpn
#add more options if needed
if [ "$1" = "uni" ]; then
    #specify lrz or eduroam and start respective services
    printf "uni-network\n"
    network="eduoram"
elif [ "$1" = "home" ]; then
    printf "home-network\n"
    network="home"
elif [ "$1" = "lrz" ]
    printf "lrz-network: will start vpn services\n"
    network="lrz"
else
    printf "no such network\n"
    exit 1
fi

interface="wlp3s0"

ip link set $interface up
printf "Interface is up.\n"

#get pid of wpa_supplicant
wpa_pid="$(ps aux | pgrep wpa)"

#check if it is running if it is, kill it
#-n returns if a var is set or not empty string
if [ -n "$wpa_pid" ]; then
    #echo $wpa_pid
    printf "Wpa_supplicant running on %d\n" $wpa_pid
    printf "killing wpa_suppicant %d\n" $wpa_pid
    kill $wpa_pid
else
    #let error="cant find wpa process"
    printf "no wpa running\n"
fi

#let user chose which script
#catch errors coming from wpa_supplicant
printf "starting wpa_suplicant\n"
wpa_supplicant -i $interface -c /etc/wpa_supplicant/$network.conf -B

dhcp_pid="$(ps aux | pgrep dhcpcd)"

if [ -n "$dhcp_pid" ]; then
    printf "dhcpcd is running on %d\n" $dhcp_pid
else
    printf "starting dhcpcd on %s\n" $interface
    dhcpcd $interface
fi

if [ "$1" = "lrz" ]; then
    printf "starting vpn service...\n"
    vpnc /etc/vpnc/lrz.conf
fi

exit 0
