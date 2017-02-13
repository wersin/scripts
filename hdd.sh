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

#h8 on windows and ntfs
ntfsfix /dev/sdb2

mount /dev/sdb2 /mnt/usb01

cd /mnt/usb01
