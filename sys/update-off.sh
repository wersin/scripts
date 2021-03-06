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
    pacman -Syu
    systemctl poweroff
    exit 0
}

main "$@"
