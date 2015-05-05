#!/bin/bash
set -x
set -e

chroot ${GB_ROOT} /bin/bash <<-'EOF'
source /etc/profile
set -x
set -e

emerge-webrsync
EOF

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
