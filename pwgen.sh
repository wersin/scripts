#!/bin/zsh

if [ "$1" = "-h" ]; then
    printf "Usage: `basename "$0"` <length> [amt of passwords]\n"
    printf "<length> the length of the password\n"
    printf "to display this '-h'\n"
    exit 1
fi


if [ -z "$1" ]; then
    printf "please specify a password length\n"
    exit 1
fi
#some magic to generate password
specials="_/%&\^\@!*=\+-"
#password="$(cat /dev/urandom | tr -dc A-Za-z0-9_/%\*_=- | head -c$1)"
password="$(cat /dev/urandom | tr -dc A-Za-z0-9$specials | head -c$1)"

printf "%s\n" "$password"

if [ -n "$2" ]; then
    for (( i=1; i < "$2"; i++ ))
    do
        password="$(cat /dev/urandom | tr -dc A-Za-z0-9$specials | head -c$1)"

        printf "%s\n" "$password"
    done
fi

exit 0
