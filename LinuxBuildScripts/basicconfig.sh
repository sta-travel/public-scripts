#!/bin/bash
# Basic configuration script to support testing

# add the servers shortname to hosts 
echo "127.0.0.1 $HostName" >> /etc/hosts

# Update the server
yum update -y

#
#
