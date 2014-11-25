#!/bin/bash
#
#
# Flush all current rules from sudo iptables
#
 sudo iptables -F

#
# Allow HTTP connections on tcp port 8081
#
sudo iptables -A INPUT -p tcp --dport 8081 -j ACCEPT

#
# Save settings
#
sudo /sbin/service iptables save
