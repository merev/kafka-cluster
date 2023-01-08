# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.ssh.insert_key = false

  config.vm.box = "merev/debian-11"

  config.vm.provider "virtualbox" do |v|
    v.gui = false
    v.memory = 2048
    v.cpus = 2
  end

  # Apache Kafka Machines - CentOS Stream 8
  (1..3).each do |i|
    config.vm.define "kafka-#{i}" do |kafka|
      kafka.vm.hostname = "kafka-#{i}"
      kafka.vm.network "private_network", ip: "192.168.99.10#{i}"
      kafka.vm.synced_folder "shared/", "/shared"
      kafka.vm.provision "shell", path: "add_hosts.sh"
      kafka.vm.provision "shell", path: "kafka_debian_setup.sh"
    end
  end
  
  # Monitoring Machine - CentOS Stream 8
  config.vm.define "monitoring" do |monitoring|
    monitoring.vm.hostname = "monitoring"
    monitoring.vm.network "private_network", ip: "192.168.99.104"
    monitoring.vm.synced_folder "shared/", "/shared"
    monitoring.vm.provision "shell", path: "add_hosts.sh"
  end

end
