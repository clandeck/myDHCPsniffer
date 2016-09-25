# myDHCPsniffer
Sniffs for Dashbutton DHCP requests and publish a MQTT message

If a Amazon Dashbutton is pressed, it first makes an ARP and then an DHCP request. This script listens for the DHCP requests and if a MAC with an Dashbutton prefix is found a MQTT message is published.
Very simple.



*.pl is the actual program

#optional
*.deamon the program embeded in a ubuntu deamon template

