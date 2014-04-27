# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "chef/ubuntu-12.04"

  config.vm.provision "shell", inline: <<-EOF
    if which puppet > /dev/null ; then
      exit 0
    fi
    wget http://apt.puppetlabs.com/puppetlabs-release-precise.deb
    sudo dpkg -i puppetlabs-release-precise.deb
    sudo apt-get install -y puppet
  EOF
  config.librarian_puppet.puppetfile_dir = '.'
  config.librarian_puppet.placeholder_filename = ".gitkeep"
  config.vm.provision "puppet" do |puppet|
    puppet.module_path = "modules"
  end
end
