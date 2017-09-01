#!/bin/bash

cmd="busctl --user call moveii.eps /moveii/eps moveii.eps"
switch_on="$cmd switchOn"
switch_off="$cmd switchOff"

mod[0]="2SMARD1"
mod[1]="2SMARD2"

two_smard1() {
    switch_on_s="$switch_on s \"${mod[0]}\""
    switch_on_s=( $(eval $switch_on_s) )
    printf "\nSwitching ${mod[0]} on:\n"
    if [ "${switch_on_s[1]}" == "true" ]; then
        printf "\t${mod[0]} switched on\n"
    else
        printf "\tCan't switch ${mod[0]} on\n"
    fi

    #wait before switching off
    sleep 1
    switch_off_s="$switch_off \"s\" \"${mod[0]}\""
    #printf "%s\n" "$switch_off_s"
    switch_off_s=( $(eval $switch_off_s) )
    printf "\nSwitching ${mod[0]} off:\n"
    if [ "${switch_off_s[1]}" == "true" ]; then
        printf "\t${mod[0]} switched off\n"
    else
        printf "\tCouldn't switch ${mod[0]} off\n"
    fi
}

two_smard2() {
    switch_on_s="$switch_on s \"${mod[1]}\""
    switch_on_s=( $(eval $switch_on_s) )
    printf "\nSwitching ${mod[1]} on:\n"
    if [ "${switch_on_s[1]}" == "true" ]; then
        printf "\t${mod[1]} switched on\n"
    else
        printf "\tCan't switch ${mod[1]} on\n"
    fi

    #wait before switching off
    sleep 1
    switch_off_s="$switch_off \"s\" \"${mod[1]}\""
    #printf "%s\n" "$switch_off_s"
    switch_off_s=( $(eval $switch_off_s) )
    printf "\nSwitching ${mod[1]} off:\n"
    if [ "${switch_off_s[1]}" == "true" ]; then
        printf "\t${mod[1]} switched off\n"
    else
        printf "\tCouldn't switch ${mod[1]} off\n"
    fi
}
main() {
    while [ true ]
    do
        two_smard1
        sleep 1
        two_smard2
        sleep 1
    done
}

main "$@"
