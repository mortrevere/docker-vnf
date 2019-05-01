#! /bin/bash

sysctl -w net.ipv4.ip_forward=1

iptables -t nat -F
iptables -t mangle -F
iptables -F
iptables -X

iptables -P FORWARD DROP
iptables -P INPUT DROP
iptables -P OUTPUT DROP

iptables -A FORWARD -o fwin-0 -m state --state NEW -j REJECT --reject-with icmp-port-unreachable
iptables -A FORWARD -i fwin-0 -j ACCEPT
iptables -A FORWARD -o fwin-0 -m state ! --state NEW -j ACCEPT

iptables -L
