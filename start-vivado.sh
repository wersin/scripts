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
    ./xilinx/Vivado/2018.3/settings64.sh
    ./xilinx/Vivado/2018.3/bin/vivado &
    exit 0
}

main "$@"
