#!/bin/bash

if [ $# -ne 1 ];then
	echo "[*] Usage: bash $0 <target>"
	exit 1
else
	for dom in $(host -t ns $1 | awk '{print $4}'); do
		echo "========================="
		#echo $dom
		host -l $1 $dom
		if [ $? -eq 0 ]; then
			break
		fi
	done
fi
