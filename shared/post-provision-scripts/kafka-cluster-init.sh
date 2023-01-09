#!/bin/bash
# Execute this script from the ansible workspace directory (/home/vagrant/ansible).

echo "* Initialize the kafka cluster ..."
sudo ansible-playbook kafka-cluster-init.yml
