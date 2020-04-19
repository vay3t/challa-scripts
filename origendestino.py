import dpkt
import socket

def printPcap(pcap):
	for (ts,buf) in pcap:
		try:
			eth = dpkt.ethernet.Ethernet(buf)
			ip = eth.data
			src = socket.inet_ntoa(ip.src)
			dst = socket.inet.ntoa(ip.dst)
			print "[+] Src: %s ---> Dst: %s" %(src,dst)
		except:
			pass

def main():
	f = open("../out.pcap")
	pcap = dpkt.pcap.Reader(f)
	printPcap(pcap)

if __name__ == '__main__':
	main()
