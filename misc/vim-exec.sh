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
    base_name=$(basename -s .c "$1")
    #TODO execute a Makefile with specified arguments ?
    echo "gcc -Wall -ggdb "$1" -o $base_name"
    gcc -Wall -ggdb "$1" -o $base_name
    ./$base_name
    #make $base_name
    #./$base_name asda "test tes 2"
    exit 0
}

main "$@"
