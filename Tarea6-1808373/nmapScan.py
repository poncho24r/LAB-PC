#!/usr/bin/python3
import nmap
ip=input("Ingresa la IP a escanear: ")
nm = nmap.PortScanner()
puertos_abiertos="-p "
results = nm.scan(hosts=ip,arguments="-sT -n -Pn -T4")
count=0
#print (results)
print("\nHost:  %s" % ip)
print("Estado:  %s" % nm[ip].state())
for proto in nm[ip].all_protocols():
	print("Protocolo:  %s" % proto)
	print()
	lport = nm[ip][proto].keys()
	sorted(lport)
	for port in lport:
		print ("port : %s\tstate : %s" % (port, nm[ip][proto][port]["state"]))
		if count==0:
			puertos_abiertos=puertos_abiertos+str(port)
			count=1
		else:
			puertos_abiertos=puertos_abiertos+","+str(port)
print("\nPuertos abiertos: "+ puertos_abiertos +" "+str(ip))
