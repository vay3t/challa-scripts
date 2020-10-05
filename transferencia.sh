#!/bin/bash

function transferencia(){
    rootdom=$1
    for domservers in $(host -t ns $rootdom | grep "name server"| awk '{print $4}' | sed 's/\.$//g'); do
        host -l $rootdom $domservers && break
    done | awk '{print $1}' | grep -vE "^(Using|Name\:|Address\:|Aliases\:|\;|Host)$|^$|\;\;" | sort -u  | tee $rootdom.axfr
}

while read line; do
    transferencia $line
    if [ ! -s $line.axfr ]; then
        rm $line.axfr
    fi
done
