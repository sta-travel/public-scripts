#!/bin/bash

# Script to build a salt minion on launch, will need to collect a generic template and then update for the 
# specific environment
#

# will need a commandline variable for environment name and profile names

# Set a bunch of variables
TemplateName=$1
ProfileName=$2
EnvironmentName=$3
HostName=`hostname`

# Download the correct template from github and name it minion for ease of access
wget https://raw.githubusercontent.com/sta-travel/public-scripts/master/SaltConfigurations/$TemplateName-template  -O minion


# Update parameters in the salt file to reflect the environment
sed -i -e "s/<ProfileName>/$ProfileName/g" minion
sed -i -e "s/<EnvironmentName>/$EnvironmentName/g" minion


# Copy the minion file to the correct location
sudo cp minion /etc/salt/minion 

# set the salt ID to the servers hostname
$HostName > /etc/salt/minion_id 

# add the servers shortname to hosts 
echo "127.0.0.1 $HostName" >> /etc/hosts

# Update the server
yum update -y

# Restart the salt service
service salt-minion restart

# Call the salt state
salt-call state.highstate