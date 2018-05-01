#!/bin/bash
# Install and Configure snmpd and firewall on Centos 7 to enable monitoring by Solarwinds or any snmp based monitor
# snmpd.conf will need network settings edited to suit the environemnt
yum install -y net-snmp-utils net-snmp
cd /etc/snmp
mv snmpd.conf snmpd.conf.orig
wget https://github.com/sta-travel/public-scripts/blob/master/LinuxBuildScripts/snmpd.conf
cd /etc/firewalld/services
wget https://github.com/sta-travel/public-scripts/blob/master/LinuxBuildScripts/snmp.xml
firewall-cmd --zone=public --add-service snmp --permanent
firewall-cmd --reload
service snmpd restart