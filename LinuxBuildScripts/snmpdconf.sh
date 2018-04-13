#!/bin/bash
# Install and Configure snmpd on Centos 7 to enable monitoring by Solarwinds
yum install -y net-snmp-utils net-snmp
cd /etc/snmp
mv snmpd.conf snmpd.conf.orig
wget {github url for snmpd.conf}
cd /etc/firewalld/services
wget {github snmp.xml}
firewall-cmd --zone=public --add-service snmp --permanent
firewall-cmd --reload