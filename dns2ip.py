import socket
import sys

try:
	lista_ip = []
	with open(sys.argv[1],"r") as obj:
		cont = 1
		for line in obj.readlines():
			#print "[!] transformando " + str(cont) + "/" + str(len(xlines))
			line = line.rstrip()
			try:
				dom2ip = socket.gethostbyname(line)
				print "[+]" + line + " --> " + dom2ip
				cont += 1
			except socket.gaierror:
				print "[-]" + line + " --> null"
				cont += 1
except KeyboardInterrupt:
	print "Exit!"
