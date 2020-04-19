#!/bin/bash

# usage: bash $0 <stdin>
# ex: 
# 	for num in {1..255}; do echo 192.168.1.$num; done > ipes.txt
#	bash $0 ipes.txt
# ex:
#	echo 127.0.0.1 | bash $0


function ttldiscover(){
	target=$1
	pinnger=$(ping -c1 $target)
	if [ $? -eq 0 ]; then
		num=$(echo $pinger | grep -oE "ttl\=[0-9]{1,3}" | cut -d "=" -f2)
		if [[ (($num -le 64)) || (($num -ge 61)) ]]; then
			echo $target linux
		elif [[ (($num -le 128)) || (($num -ge 122)) ]]; then
			echo $target windows
		else
			echo $target unknown $num
		fi
		exit
	fi
}


while read line
do
	ttldiscover $line &
done < "${1:-/dev/stdin}"; wait




