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
    while [[ $# -gt 0 ]]
    do
        key="$1"
        case $key in
        -w)
            cp ~/Games/realmlist.wtf.warmane ~/Games/World\ of\ Warcraft/Data/enGB/realmlist.wtf
            echo "changed to warmane"
            wine ~/Games/World\ of\ Warcraft/Wow.exe -opengl
            ;;
        -a)
            cp ~/Games/realmlist.wtf.aura ~/Games/World\ of\ Warcraft/Data/enGB/realmlist.wtf
            echo "changed to aura"
            wine ~/Games/World\ of\ Warcraft/Wow.exe -opengl
            ;;
        *)
            echo "nothing specified"
                    # unknown option

            ;;
        esac
        shift # past argument or value
    done
    exit 0
}

main "$@"
