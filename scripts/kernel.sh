#!/bin/bash
set -x
set -e

chroot ${GB_ROOT} /bin/bash <<-EOF
source /etc/profile
set -x
set -e
emerge -pv '${GB_KERNEL_PACKAGE}' || env CONFIG_PROTECT_MASK=/etc emerge --noreplace --autounmask-write -v '${GB_KERNEL_PACKAGE}' || true
emerge --noreplace -v '${GB_KERNEL_PACKAGE}'
EOF

if [ -n "${GB_KERNEL_TARBALL}" ]; then
  wget -O "${GB_ROOT}/kernel-tarball" "${GB_KERNEL_TARBALL}"
  tar xf "${GB_ROOT}/kernel-tarball" -C "${GB_ROOT}"
else
  wget -O "${GB_ROOT}/usr/src/linux/.config" "${GB_KERNEL_CONFIG}"

  chroot ${GB_ROOT} /bin/bash <<-'EOF'
source /etc/profile
set -x
set -e

cd /usr/src/linux
chmod 644 /usr/src/linux/.config
make olddefconfig
make localyesconfig
make -j`nproc`
make -j`nproc` modules_install
make install
  EOF
fi
