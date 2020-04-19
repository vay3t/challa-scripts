#!/usr/bin/python

from scapy.all import *

HOST = []

def fn_filter(pkg):
	if IP in pkg:
		if not pkg[IP].src in HOST:
			HOST.append(pkg[IP].src)

def main():
	print "[*] Iniciando sniffer"
	sniff(iface="wlan0", prn=fn_filter)
	print "[*] Finalizando sniffer"
	print "[*] Host descubiertos:"
	for x in HOST:
		print "    - %s" %x

if __name__ == '__main__':
	main()
