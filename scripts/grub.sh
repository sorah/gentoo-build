#!/bin/bash
set -x
set -e

chroot ${GB_ROOT} /bin/bash <<-'EOF'
source /etc/profile
set -x
set -e

emerge --noreplace -v sys-boot/grub
echo 'GRUB_CMDLINE_LINUX="${GRUB_CMDLINE_LINUX} init=/usr/lib/systemd/systemd"' >> /etc/default/grub
EOF

chroot ${GB_ROOT} /bin/bash <<-EOF
source /etc/profile
set -x
set -e

if grep -q ' /boot ' /proc/mounts; then
  if grep ' /boot ' /proc/mounts | grep -q rw; then
    mount -o rw,remount /boot
  fi
fi

grub2-install --no-floppy /dev/${GB_ROOTDEVICE}
grub2-mkconfig -o /boot/grub/grub.cfg
EOF
