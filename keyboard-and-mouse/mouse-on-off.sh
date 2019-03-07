#!/bin/bash

function usage()
{
    cat <<EOF
Usage: $0 MOUSE-STATE

MOUSE-STATE:
    on|enable|enabled|1     Enable mouse
    off|disable|disabled|0  Disable mouse
    test|mouse              Display mouse name
EOF
}

if test "$DISPLAY"; then
    mouse_name=$(xinput list --name-only | grep -B1 'Virtual core keyboard' | head -n 1)

    if [[ "$1" =~ ^(on|enable|enabled|1)$ ]]; then
        xinput --set-prop "$mouse_name" "Device Enabled" "1"
        echo "on"
    elif [[ "$mouse_name"  &&  "$1" =~ ^(off|disable|disabled|0)$ ]]; then
        xinput --set-prop "$mouse_name" "Device Enabled" "0"
        echo "off"
    elif [[ "$1" =~ ^(test|mouse)$ ]]; then
        echo "Mouse name: ${mouse_name}"
    else
        echo "Mouse name: ${mouse_name}" >&2
        usage >&2
    fi
else
    echo "Mouse name: UNKNOWN (No X server ???)"
    if [[ "$1" =~ ^(on|enable|enabled|1|off|disable|disabled|0)$ ]]; then
        echo "on"
    elif [[ "$1" =~ ^(test|mouse)$ ]]; then
        :
    else
        usage >&2
    fi
fi
