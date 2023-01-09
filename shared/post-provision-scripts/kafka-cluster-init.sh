#!/bin/bash
# Execute this script from the ansible workspace directory (/home/vagrant/ansible).

echo "* Run Zookeeper processes ..."
sudo ansible-playbook kafka-zookeeper-start.yml

echo "* Wait till the Zookepers choose a leader (15 seconds) ..."
sleep 15

echo "* Run Kafka brokers ..."
sudo ansible-playbook kafka-broker-start.yml