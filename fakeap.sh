#!/bin/bash

# configs
upstream=wlan0
phy=wlan1

cat <<EOF > hostapd.conf
interface=$phy
driver=nl80211
ssid=Plaza de Armas
channel=6
bssid=DD:3E:A8:A4:A2:8F
#macaddr_acl=0
#auth_algs=1
#ignore_broadcast_ssid=0
#wpa=2
#wpa_passpharse=4n0np4ssw0rd
#wpa_key_mgmt=WPA-PSK
#wpa_pairwise=TKIP
#rsn_pairwise=CCMP
EOF

# iptables rules
iptables -t nat -A POSTROUTING -o $upstream -j MASQUERADE
iptables -A FORWARD -i $phy -o $upstream -j ACCEPT
echo 1 > /proc/sys/net/ipv4/ip_forward


# dnsmasq configs
cat <<EOF > dnsmasq.conf
log-facility=/var/log/dnsmasq.log
interface=$phy
listen-address=10.0.0.1
bind-interfaces
bogus-priv
dhcp-range=10.0.0.100,10.0.0.250,12h
dhcp-option=3,10.0.0.1
dhcp-option=6,10.0.0.1
#no-resolv
log-queries
EOF

dnsmasq -C dnsmasq.conf -d &
hostapd hostapd.conf &

read

killall -9 dnsmasq hostapd
