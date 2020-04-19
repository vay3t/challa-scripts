#!/bin/bash

for ip in {1..254}; do
	bash -c "ping -c1 192.168.1.$ip &> /dev/null" && echo 192.168.1.$ip &
done; wait