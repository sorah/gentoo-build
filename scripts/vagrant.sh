#!/bin/bash
set -x
set -e

# http://docs.vagrantup.com/v2/boxes/base.html

chroot ${GB_ROOT} /bin/bash <<-'EOF'
source /etc/profile
set -x
set -e

mkdir -p ~vagrant/.ssh

# https://github.com/mitchellh/vagrant/blob/master/keys/vagrant.pub
echo 'ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEA6NF8iallvQVp22WDkTkyrtvp9eWW6A8YVr+kz4TjGYe7gHzIw+niNltGEFHzD8+v1I2YJ6oXevct1YeS0o9HZyN1Q9qgCgzUFtdOKLv6IedplqoPkcmF0aYet2PkEDo3MlTBckFXPITAMzF8dJSIFo9D8HfdOV0IAdx4O7PtixWKn5y2hMNG0zQPyUecp4pzC6kivAIhyfHilFR61RGL+GPXQ2MWZWFYbAGjyiYJnAmCP3NOTd0jMZEnDkbUvxhMmBYSdETk1rRgm+R4LOzFUGaHqHDLKLX+FIPKcF96hrucXzcWyLbIbEgE98OHlnVYCzRdK8jlqm8tehUc9c9WhQ== vagrant insecure public key' > ~vagrant/.ssh/authorized_keys

chmod 700 ~vagrant/.ssh
chmod 600 ~vagrant/.ssh/authorized_keys
chown vagrant:vagrant ~vagrant/.ssh
chown vagrant:vagrant ~vagrant/.ssh/authorized_keys

echo 'vagrant:vagrant' | chpasswd

echo 'UseDNS no' >> /etc/ssh/sshd_config
EOF
