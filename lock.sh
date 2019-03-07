#!/bin/bash

i3lock-fancy
sleep 1

xinput --set-prop "Logitech Gaming Mouse G402" "Device Enabled" "0"
# mouse=$(/home/mark/git-repos/scripts/mouse-on-off.sh off)

xset +dpms
xset dpms force off

#if [[ "$mouse" == 'off' ]]; then
zenity --question --text "Reactivate Mouse"; echo $?
# /home/mark/git-repos/scripts/mouse-on-off.sh on
xinput --set-prop "Logitech Gaming Mouse G402" "Device Enabled" "1"
#fi
