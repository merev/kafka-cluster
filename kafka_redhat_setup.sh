#!/bin/bash

echo "* Add any prerequisites ..."
dnf install -y python3 python3-pip java-17-openjdk

echo "* Stop the firewall ..."
systemctl disable --now firewalld

echo "* Download the recent package ..."
wget https://dlcdn.apache.org/kafka/3.3.1/kafka_2.13-3.3.1.tgz

echo "* Extract the archive and remove it..."
tar xzvf kafka_2.13-3.3.1.tgz && rm -rf kafka_2.13-3.3.1.tgz

echo "* Export Env Variable ..."
export KAFKA_NODE_ID=$(echo "${HOSTNAME: -1}")

echo "* Create Zookeeper folder and myid file ..."
mkdir /tmp/zookeeper && echo $KAFKA_NODE_ID > /tmp/zookeeper/myid