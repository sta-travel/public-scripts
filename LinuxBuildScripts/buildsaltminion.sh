#!/bin/bash

# Script to build a salt minion on launch, will need to collect a generic template and then update for the 
# specific environment
#

# will need a commandline variable for environment name and profile names

# Set a bunch of variables
TemplateName=$1
ProfileName=$2
EnvironmentName=$3
FirewallProfile=$1
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

# Firewall configuration
# create a case for the various firewall configurations for centos 7 servers, webapp server
# tdp app server, mui server, memcached server, etc

case $FirewallProfile in
  tdpapp)
  firewall-cmd --zone=public --add-ports=8080/tcp --permanent
  firewall-cmd --zone=public --add-ports=9090/tcp --permanent
  firewall-cmd --zone=public --add-ports=6702/tcp --permanent
  firewall-cmd --zone=public --add-ports=6601/tcp --permanent
  firewall-cmd --reload
  ;;
  uiserver)
  ;;
  *)
  echo "no firewall config"
  ;;
esac

# Call the salt state
salt-call state.highstate

# exit gracefully
exit 0