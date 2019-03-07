#!/bin/zsh

my-packages () {
    comm -23 <(pacman -Qeq | sort) <(pacman -Qgq base base-devel xorg | sort)
}


main()
{
    my-packages
    exit 0
}

main "$@"
