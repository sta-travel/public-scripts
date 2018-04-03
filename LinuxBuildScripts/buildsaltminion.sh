#!/bin/bash

# Script to build a salt minion on launch, will need to collect a generic template and then update for the 
# specific environment
#

# will need a commandline variable for environment name and profile names

TemplateName=$1
ProfileName=$2
EnvironmentName=$3
HostName=`hostname`

#
wget https://raw.githubusercontent.com/sta-travel/public-scripts/master/SaltConfigurations/$TemplateName-template  -O minion

sed -i -e "s/<ProfileName>/$ProfileName/g" minion
sed -i -e "s/<EnvironmentName>/$EnvironmentName/g" minion

sudo cp minion /etc/salt/minion 
$HostName > /etc/salt/minion_id 
echo "127.0.0.1 $HostName >> /etc/hosts

service salt-minion restart