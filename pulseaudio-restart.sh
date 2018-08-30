#!/bin/sh

restart_audio()
{
    pulseaudio -k
    pulseaudio --start
}

main()
{
    restart_audio
    exit 0
}

main "$@"
