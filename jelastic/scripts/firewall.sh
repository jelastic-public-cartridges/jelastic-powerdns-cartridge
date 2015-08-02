#!/bin/bash

/sbin/iptables -t nat -I PREROUTING -p tcp -m tcp --dport 80 -j REDIRECT --to-ports 8080
/sbin/iptables -t nat -I PREROUTING -p tcp -m tcp --dport 443 -j REDIRECT --to-ports 8473
/sbin/iptables -I INPUT -p udp --dport 53 -j ACCEPT
