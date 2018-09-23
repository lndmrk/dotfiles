$provision_dotfiles = <<EOF
. /vagrant/bootstrap.sh
dotfiles enable
EOF

Vagrant.configure("2") do |config|
  config.vm.synced_folder ".", "/vagrant", type: "sshfs"
  config.vm.provider "libvirt" do |lv|
    lv.cpus = 2
    lv.memory = 2048
    lv.graphics_type = "spice"
    lv.video_type = "virtio"
  end

  config.vm.define "debian" do |debian|
    debian.vm.box = "debian/stretch64"
    debian.vm.provision "shell", inline: "echo 'vagrant:vagrant' | chpasswd"
  end

  config.vm.define "fedora" do |fedora|
    fedora.vm.box = "fedora/28-cloud-base"
  end

  config.vm.provision "dotfiles", type: "shell" do |d|
    d.inline = $provision_dotfiles
    d.privileged = false
  end
end
