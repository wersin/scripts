#!/bin/bash

usage()
{
    echo "---------------------------------"
    echo "Program to generate random passwords using kernels random number generator."
    echo "Default: generates one password of length 8"
    echo "Usage:"
    echo "-h, --help     Print this help message"
    echo "-n, --amount	 Amount of passwords to generate"
    echo "-l, --length   Length of passwords to generate"
    echo "example: $1 -id 120 -f jpg -d my-folder"
    echo "---------------------------------"
    exit 0
}

gen_pw()
{
    num=$2
    length=$1
    if [ -z "$2" ]; then
        num=8
    else
        num="$2"
    fi

    echo $2

    if [ -z ${1+x} ]; then
        length=8
    else
        length="$1"
    fi
    #some magic to generate password
    specials="_/%&\^\@!*=\+-"
    #password="$(cat /dev/urandom | tr -dc A-Za-z0-9_/%\*_=- | head -c$1)"
    password="$(cat /dev/urandom | tr -dc A-Za-z0-9$specials | head -c$length)"

    printf "%s\n" "$password"
    #TODO: 	pass num as second argumen
    if [ -n "$num" ]; then
        for (( i=1; i < $num; i++ ))
        do
            password="$(cat /dev/urandom | tr -dc A-Za-z0-9$specials | head -c$length)"

            printf "%s\n" "$password"
        done
    fi

}

main()
{
    if [ "$1" == "--help" ] || [ "$1" == "-h" ] || [ -z ${1+x} ]; then
        usage $0
    fi

    while [[ $# -gt 1 ]]
    do
        key="$1"

        case $key in
        -l|--length)
            len="$2"
            ;;
        -n|--amount)
            num="$2"
            ;;
            *)
                    # unknown option
            ;;
        esac
        shift # past argument or value
    done
    echo $num
    gen_pw $len $num
    exit 0
}

main "$@"


#length=8
#while getopts ':hl:n:' option; do
#  case "$option" in
#    h) echo "$usage"
#       exit
#       ;;
#    l) length=$OPTARG
#       ;;
#    n) num=$OPTARG
#       ;;
#    :) printf "missing argument for -%s\n" "$OPTARG" >&2
#       echo "$usage" >&2
#       exit 1
#       ;;
#   \?) printf "illegal option: -%s\n" "$OPTARG" >&2
#       echo "$usage" >&2
#       exit 1
#       ;;
#  esac
#done
#shift $((OPTIND - 1))

#some magic to generate password
#specials="_/%&\^\@!*=\+-"
##password="$(cat /dev/urandom | tr -dc A-Za-z0-9_/%\*_=- | head -c$1)"
#password="$(cat /dev/urandom | tr -dc A-Za-z0-9$specials | head -c$length)"
#
#printf "%s\n" "$password"
#
#if [ -n "$num" ]; then
#    for (( i=1; i < $num; i++ ))
#    do
#        password="$(cat /dev/urandom | tr -dc A-Za-z0-9$specials | head -c$length)"
#
#        printf "%s\n" "$password"
#    done
#fi
#
#exit 0
