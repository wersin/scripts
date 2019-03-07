#!/bin/sh

#user nees to be root
root()
{
    #user must be root to run this
    if [ "$EUID" -ne 0 ]
        then echo "Must be root to run this"
        exit 1
    fi
}

main()
{
    #user not necessarily needs to be root
    root $1
    #$addreses=${cat scan-report | grep report | awk '{print $NF;}'}
    for (( i=1; i < $num; i++ ))
    do
        printf "%s\n" "$password"
    done
    ip link set wlp3s0 down
    ip addr change dev wlp3s0 a8:96:75:1f:03:dc
    ip link set wlp3s0 up
    exit 0
}

main "$@"
