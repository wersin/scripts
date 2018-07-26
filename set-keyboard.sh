#!/bin/sh

#awk '{print $(NF-1), $NF;}' to print e.g. the last element and last-1
layout=$(setxkbmap -print -verbose 10 | sed -n 9p | awk '{print $NF;}')

#toggle between de and us-layout, expand as needed
if [ "$layout" = "de" ]; then
    setxkbmap us
else
    setxkbmap de
fi
