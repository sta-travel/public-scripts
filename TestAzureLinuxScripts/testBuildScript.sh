#!/bin/bash
curl -L https://bootstrap.saltstack.com | sudo sh 
wget https://raw.githubusercontent.com/sta-travel/public-scripts/master/TestSaltConfigs/testSaltMinonConfig  -O test-minion
sudo cp test-minion /etc/salt/minion 
hostname > /etc/salt/minion_id 
service salt-minion restart