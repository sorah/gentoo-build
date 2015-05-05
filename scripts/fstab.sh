#!/bin/bash
set -x
set -e

cat > ${GB_ROOT}/etc/fstab <<EOF
/dev/${GB_ROOTDEVICE}1 /boot ext4 defaults,noatime 1 1
/dev/${GB_ROOTDEVICE}3 / ${GB_ROOT_FSTYPE} defaults,noatime 1 2
EOF
