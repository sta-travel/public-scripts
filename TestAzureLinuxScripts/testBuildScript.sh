#!/bin/bash
curl -L https://bootstrap.saltstack.com | sudo sh 
wget http://10.37.1.10/server-setup/test-minion 
sudo cp test-minion /etc/salt/minion 
hostname > /etc/salt/minion_id 
service salt-minion restart