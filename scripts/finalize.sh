#!/bin/bash
set -x
set -e

chroot ${GB_ROOT} /bin/bash <<-'EOF'
source /etc/profile
set -x
set -e
rm -f /etc/resolv.conf
ln -snf /run/systemd/resolve/resolv.conf /etc/resolv.conf
EOF

if [ "_$GB_REMOVE_PORTAGE" = "_1" ]; then
  chroot ${GB_ROOT} /bin/bash <<-'EOF'
source /etc/profile
set -x
set -e
rm -rf /usr/portage
EOF
fi
