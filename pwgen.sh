#!/bin/zsh

usage="$(basename "$0") [-h] [-l] [-n] -- program to generate random passwords using kernels random number generator.\n
Default: generates password of length 8

where:
    -h  show this help text
    -l  specify length of password
    -n  specify amount of passwords (optional)
"

length=8
#num=1;
while getopts ':hl:n:' option; do
  case "$option" in
    h) echo "$usage"
       exit
       ;;
    l) length=$OPTARG
       ;;
    n) num=$OPTARG
       ;;
    :) printf "missing argument for -%s\n" "$OPTARG" >&2
       echo "$usage" >&2
       exit 1
       ;;
   \?) printf "illegal option: -%s\n" "$OPTARG" >&2
       echo "$usage" >&2
       exit 1
       ;;
  esac
done
shift $((OPTIND - 1))

if [ "$1" = "-h" ]; then
    printf "Usage: `basename "$0"` <length> [amt of passwords]\n"
    printf "<length> the length of the password\n"
    printf "to display this '-h'\n"
    exit 1
fi

#some magic to generate password
specials="_/%&\^\@!*=\+-"
#password="$(cat /dev/urandom | tr -dc A-Za-z0-9_/%\*_=- | head -c$1)"
password="$(cat /dev/urandom | tr -dc A-Za-z0-9$specials | head -c$length)"

printf "%s\n" "$password"

if [ -n "$num" ]; then
    for (( i=1; i < $num; i++ ))
    do
        password="$(cat /dev/urandom | tr -dc A-Za-z0-9$specials | head -c$length)"

        printf "%s\n" "$password"
    done
fi

exit 0
