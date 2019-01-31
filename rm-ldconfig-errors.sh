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
    error_message="error: No package owns"
    error_message_length=${#error_message}
    echo "$error_message_length"
    libs=( $(cat pacman-error-list | awk '{print $1}') )
    # libs=( $(cat ldconfig-list | awk '{print $3}') )
    echo "${#libs[@]}"
    for i in "${libs[@]}"
    do
        out=$(pacman -Qo $i 2>&1 | cut -c1-$error_message_length)
        # remove libs if unowned by any package
        if [ "$out" == "$error_message" ]; then
                echo "removing $i"
                rm $i
        fi

    done
    exit 0
}

main "$@"
