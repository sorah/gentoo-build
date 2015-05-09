#!/bin/bash
set -x
set -e

chroot ${GB_ROOT} /bin/bash <<-'EOF'
source /etc/profile
set -x
set -e

emerge -v --noreplace 'app-emulation/cloud-init'

cat >/etc/cloud/cloud.cfg <<-'EOC'
# The top level settings are used as module
# and system configuration.

# A set of users which may be applied and/or used by various modules
# when a 'default' entry is found it will reference the 'default_user'
# from the distro configuration specified below
users:
   - default

# If this is set, 'root' will not be able to ssh in and they
# will get a message to login instead as the above $user (ubuntu)
disable_root: true

# This will cause the set+update hostname module to not operate (if true)
preserve_hostname: false

# Example datasource config
# datasource:
#    Ec2:
#      metadata_urls: [ 'blah.com' ]
#      timeout: 5 # (defaults to 50 seconds)
#      max_wait: 10 # (defaults to 120 seconds)

# The modules that run in the 'init' stage
cloud_init_modules:
 - migrator
 - seed_random
 - bootcmd
 - write-files
 - growpart
 - resizefs
 - set_hostname
 - update_hostname
 - update_etc_hosts
 - ca-certs
 - rsyslog
 - users-groups
 - ssh

# The modules that run in the 'config' stage
cloud_config_modules:
 - disk_setup
 - mounts
 - ssh-import-id
 - locale
 - set-passwords
 - package-update-upgrade-install
 - landscape
 - timezone
 - puppet
 - chef
 - salt-minion
 - mcollective
 - disable-ec2-metadata
 - runcmd
 - byobu

# The modules that run in the 'final' stage
cloud_final_modules:
 - rightscale_userdata
 - scripts-vendor
 - scripts-per-once
 - scripts-per-boot
 - scripts-per-instance
 - scripts-user
 - ssh-authkey-fingerprints
 - keys-to-console
 - phone-home
 - final-message
 - power-state-change

# System and/or distro specific settings
# (not accessible to handlers/transforms)
system_info:
   # This will affect which distro class gets used
   distro: gentoo
   # Default user name + that default users groups (if added/used)
   default_user:
     name: gentoo
     lock_passwd: True
     gecos: Gentoo
     groups: [wheel]
     sudo: ["ALL=(ALL) NOPASSWD:ALL"]
     shell: /bin/bash
   # Other config here will be given to the distro class and/or path classes
   paths:
      cloud_dir: /var/lib/cloud/
      templates_dir: /etc/cloud/templates/
EOC


ln -sfv /usr/lib64/systemd/system/cloud-config.service /etc/systemd/system/multi-user.target.wants/cloud-config.service
ln -sfv /usr/lib64/systemd/system/cloud-final.service /etc/systemd/system/multi-user.target.wants/cloud-final.service
ln -sfv /usr/lib64/systemd/system/cloud-init-local.service /etc/systemd/system/multi-user.target.wants/cloud-init-local.service
ln -sfv /usr/lib64/systemd/system/cloud-init.service /etc/systemd/system/multi-user.target.wants/cloud-init.service
EOF
