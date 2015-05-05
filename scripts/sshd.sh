#!/bin/bash
set -x
set -e

chroot ${GB_ROOT} /bin/bash <<-'EOF'
source /etc/profile
set -x
set -e

ln -sfv /usr/lib64/systemd/system/sshd.service /etc/systemd/system/multi-user.target.wants/sshd.service
EOF
