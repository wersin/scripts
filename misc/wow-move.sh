#!/bin/sh

keydown()
{
    #xdotool keydown --window "wow.exe" keydown $1
    xdotool keydown --delay 60 $1
    xdotool keyup --delay 60 $1
}

#user nees to be root
move()
{
    keydown w
    sleep 2
    keydown w
    sleep 2
    keydown s
    sleep 2
    keydown s
    sleep 2
}

main()
{
    sleep 5
    while true; do
        move
    done
    exit 0
}

main "$@"
