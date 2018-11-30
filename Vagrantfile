# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
N = 1
Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/xenial64"
  config.vm.provision "shell", inline: "sudo apt-get update && sudo apt-get install -y python python-dev"
  config.vm.define "terraform" do |tf|
    tf.vm.hostname = "terraform"
    tf.vm.provision "ansible" do |ansible|
      ansible.playbook = "playbooks/terraform.yaml"
      ansible.limit = "hashistack"
      ansible.groups = {
          "hashistack" => ["terraform"],
          "all_groups:children" => ["hashistack"],
          "hashistack:vars" => {
              "tfe_token" => "#{ENV['TFE_TOKEN']}"
          }
      }
    end
  end
end
