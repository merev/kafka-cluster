#!/bin/bash

echo "* Add any prerequisites ..."
apt-get update -y && apt-get install -y python3 python3-pip openjdk-17-jre

echo "* Add kafka-python ..."
pip3 install kafka-python

echo "* Download the recent package ..."
wget https://dlcdn.apache.org/kafka/3.3.1/kafka_2.13-3.3.1.tgz

echo "* Extract the archive and remove it ..."
tar xzvf kafka_2.13-3.3.1.tgz && rm -rf kafka_2.13-3.3.1.tgz

echo "* Export Env Variable ..."
export KAFKA_NODE_ID=$(echo "${HOSTNAME: -1}")

echo "* Create Zookeeper folder and myid file ..."
mkdir /tmp/zookeeper
echo $KAFKA_NODE_ID > /tmp/zookeeper/myid

echo "* Prepare the Zookeeper configuration ..."
cp /shared/kafka-config/zookeeper.properties /home/vagrant/kafka_2.13-3.3.1/config/zookeeper.properties

echo "* Prepare the kafka broker configuration ..."
sed -i "24s/0/$KAFKA_NODE_ID/" /home/vagrant/kafka_2.13-3.3.1/config/server.properties
sed -i '38s/#//' /home/vagrant/kafka_2.13-3.3.1/config/server.properties
sed -i "38s/your.host.name/$HOSTNAME/" /home/vagrant/kafka_2.13-3.3.1/config/server.properties
sed -i '125s/localhost/kafka-1:2181,kafka-2:2181,kafka-3/' /home/vagrant/kafka_2.13-3.3.1/config/server.properties

echo "* Start the Zookeeper ..."
kafka_2.13-3.3.1/bin/zookeeper-server-start.sh -daemon kafka_2.13-3.3.1/config/zookeeper.properties

echo "* Start the Kafka Brocker ..."
kafka_2.13-3.3.1/bin/kafka-server-start.sh -daemon kafka_2.13-3.3.1/config/server.properties
