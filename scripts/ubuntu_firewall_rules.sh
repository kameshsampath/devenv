#!/bin/bash
#
#
# Flush all current rules from sudo iptables
#
sudo ufw --force enable

sudo ufw  allow ssh

#
# Allow HTTP connections on tcp ports
#
sudo ufw allow 8081/tcp