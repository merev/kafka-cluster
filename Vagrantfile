# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.ssh.insert_key = false

  config.vm.provider "virtualbox" do |v|
    v.gui = false
    v.memory = 2048
    v.cpus = 2
  end
  
  # Ansible Host - CentOS Stream 9
  config.vm.define "ans" do |ans|
    ans.vm.box = "merev/centos-stream"
    ans.vm.hostname = "ansible"
    ans.vm.network "private_network", ip: "192.168.99.100"
    ans.vm.synced_folder "shared/", "/shared"
    ans.vm.provision "shell", path: "initial-config/add_hosts.sh"
    ans.vm.provision "shell", path: "initial-config/ansible/redhat_ansible_setup.sh"
    ans.vm.provision "shell", path: "initial-config/monitoring/node_exp_setup.sh"
  end

  # Apache Kafka Machines - Debian 11
  (1..3).each do |i|
    config.vm.define "kafka-#{i}" do |kafka|
      kafka.vm.box = "merev/debian-11"
      kafka.vm.hostname = "kafka-#{i}"
      kafka.vm.network "private_network", ip: "192.168.99.10#{i}"
      kafka.vm.synced_folder "shared/", "/shared"
      kafka.vm.provision "shell", path: "initial-config/add_hosts.sh"
      kafka.vm.provision "shell", path: "initial-config/ansible/ansible_debian_client.sh"
      kafka.vm.provision "shell", path: "initial-config/monitoring/node_exp_setup.sh"
      kafka.vm.provision "shell", path: "initial-config/kafka/kafka_debian_preparation.sh"
    end
  end
  
  # Monitoring Machine (docker host) - Debian 11
  config.vm.define "monitoring" do |monitoring|
    monitoring.vm.box = "merev/debian-11"
    monitoring.vm.hostname = "monitoring"
    monitoring.vm.network "private_network", ip: "192.168.99.104"
    monitoring.vm.synced_folder "shared/", "/shared"
    monitoring.vm.provision "shell", path: "initial-config/add_hosts.sh"
    monitoring.vm.provision "shell", path: "initial-config/ansible/ansible_debian_client.sh"
    monitoring.vm.provision "shell", path: "initial-config/monitoring/docker_setup.sh"
    monitoring.vm.provision "shell", path: "initial-config/monitoring/prometheus_setup.sh"
  end

end
