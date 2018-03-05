#!/bin/zsh

find ~/ -iname '.viminf*.tmp' > rem-vim-temps

for i in $(cat ./rem-vim-temps) ; do
    echo $i
    rm $i
done

rm rem-vim-temps
