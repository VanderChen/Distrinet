#!/bin/bash

brctl addbr br-k8s
brctl addif br-k8s eno1
ip addr flush dev eno1 
ip link set eno1 mtu 9000
ifconfig br-k8s 192.168.1.104 netmask 255.255.255.0 broadcast 192.168.1.255 mtu 9000 up
route add default gw 192.168.1.1 dev br-k8s
