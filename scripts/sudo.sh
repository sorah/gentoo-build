#!/bin/bash
set -x
set -e

chroot ${GB_ROOT} /bin/bash <<-'EOF'
source /etc/profile
set -x
set -e

emerge --noreplace -v app-admin/sudo
EOF

if [ "_${GB_SKIP_SUDOERS}" = "_1" ]; then
  echo 'skipping sudoers'
  exit 0
fi

mkdir -p ${GB_ROOT}/etc/sudoers.d
echo '%wheel ALL=(ALL) NOPASSWD: ALL' > ${GB_ROOT}/etc/sudoers.d/wheel
chown root:root ${GB_ROOT}/etc/sudoers.d/wheel
chmod 640 ${GB_ROOT}/etc/sudoers.d/wheel
