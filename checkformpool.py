import requests
import re
from multiprocessing import Pool

def checkForm(url):
	print("> "+url)
	response = requests.get(url)
	html_doc = response.text
	for line in html_doc:
		if '<form' in line:
			aux = re.match(r'method="post"', line, re.IGNORECASE)
			if aux:
				print(url)
				break

def openLinks():
	with open('/home/vay3t/arsenal/Photon/minvu.cl/all.txt',"r") as f:
		lista = f.readlines()
	listaVacia = []
	for link in lista:
		listaVacia.append(link.rstrip())
	return listaVacia

with Pool(processes=10) as p:
	p.map(checkForm,openLinks())
