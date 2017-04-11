#!/bin/bash
set -x
set -e

cat >> "${GB_ROOT}/etc/portage/make.conf" <<-EOF
USE="\${USE} ${GB_USE}"
FEATURES="\${FEATURES} ${GB_FEATURES}"
EOF

if [ -n "${GB_CFLAGS}" ]; then
  echo "CFLAGS='${GB_CFLAGS}'" >> "${GB_ROOT}/etc/portage/make.conf"
fi
if [ -n "${GB_CXXFLAGS}" ]; then
  echo "CXXFLAGS='${GB_CXXFLAGS}'" >> "${GB_ROOT}/etc/portage/make.conf"
fi

if [ -n "${GB_MIRRORS}" ]; then
  echo "GENTOO_MIRRORS='${GB_MIRRORS}'" >> "${GB_ROOT}/etc/portage/make.conf"
fi

if [ -n "${GB_BINPKG_HOST}" ]; then
  echo "PORTAGE_BINHOST='${GB_BINPKG_HOST}'" >> "${GB_ROOT}/etc/portage/make.conf"
  echo 'FEATURES="${FEATURES} getbinpkg binpkg-multi-instance"' >> "${GB_ROOT}/etc/portage/make.conf"
fi

chroot ${GB_ROOT} /bin/bash <<-'EOF'
source /etc/profile
set -x
set -e

emerge-webrsync
EOF

