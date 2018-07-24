#!/bin/sh

layout=$(setxkbmap -print -verbose 10 | sed -n 9p | awk '{print $NF;}')

if [ "$layout" = "de" ]; then
    setxkbmap us
else
    setxkbmap de
fi
