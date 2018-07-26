#!/bin/sh

#user must be root to run this
if [ "$EUID" -ne 0 ]
    then echo "Must be root to run this"
    exit -1
fi

wpa_supplicant -i wlp3s0 -c /etc/wpa_supplicant/wpa.conf -B

dhcpcd -b wlp3s0
