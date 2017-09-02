#!/bin/bash

function myfunc()
{
    local __resultvar=$1
    local myres='some val'
    eval $__resultvar="'$myres'"
}

myfunc result
echo $result
