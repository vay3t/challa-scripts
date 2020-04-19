import string

def hexdump(src, length=16, sep='.'):
	DISPLAY = string.digits + string.letters + string.punctuation
	FILTER = ''.join(((x if x in DISPLAY else '.') for x in map(chr, range(256))))
	lines = []
	for c in xrange(0, len(src), length):
		chars = src[c:c+length]
		hex = ' '.join(["%02x" % ord(x) for x in chars])
		if len(hex) > 24:
			hex = "%s %s" % (hex[:24], hex[24:])
		printable = ''.join(["%s" % FILTER[ord(x)] for x in chars])
		lines.append("%08x:  %-*s  |%s|\n" % (c, length*3, hex, printable))
	print ''.join(lines)
	
if __name__ == '__main__':
	with open("dlink/configs/config_152.231.71.181.dat") as f:
		data = f.read()
	hexdump(data)
