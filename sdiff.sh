#!/bin/sh

if [ -z "$1" ] || [ -z "$2" ]; then
    printf "specify at least 2 words\n"
    exit 1
fi

if [ "$1" = "$2" ]; then
  echo "EQUAL"
else
    echo "NOT EQUAL"
fi

