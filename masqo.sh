#!/bin/bash

# configs
upstream=wlan0
phy=eth0

# iptables rules
iptables -t nat -A POSTROUTING -o $upstream -j MASQUERADE
iptables -A FORWARD -i $phy -o $upstream -j ACCEPT
ifconfig $phy 192.168.0.1/24 up
echo '1' > /proc/sys/net/ipv4/ip_forward

# dnsmasq configs
cat <<EOF > dnsmasqo.conf
log-facility=/var/log/dnsmasq.log
interface=$phy
listen-address=192.168.0.1
bind-interfaces
bogus-priv
dhcp-range=192.168.0.100,192.168.0.250,12h
log-queries
EOF

sleep 3
dnsmasq -C dnsmasqo.conf -d &

echo "Hit enter to kill me"
read

killall dnsmasq
rm dnsmasqo.conf
iptables -F
iptables -t nat -F
ifconfig $phy down
echo '0' > /proc/sys/net/ipv4/ip_forward
