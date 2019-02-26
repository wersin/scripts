#/bin/sh

status=$(amixer | grep -A 25 Master | sed -n 6p | awk '{print $NF;}')
volume=$(amixer | grep -A 25 Master | sed -n 6p | awk -F'[][]' '{print $2}')
#echo $volume

if [ "$status" = "[on]" ]; then
    amixer sset Master mute
elif [ "$status" = "[off]" ]; then
    alsactl restore
    amixer sset Master unmute
    amixer sset Master $volume
else
    echo "No valid status $status"
fi

