#!/bin/bash
set -x
set -e

echo "/dev/${GB_ROOTDEVICE}${GB_ROOT_PARTITION} / ${GB_ROOT_FSTYPE} defaults,noatime 1 2" > ${GB_ROOT}/etc/fstab
if [ -n "${GB_BOOT_PARTITION}" -a -n "${GB_BOOT_FSTYPE}" ]; then
  echo "/dev/${GB_ROOTDEVICE}${GB_BOOT_PARTITION} /boot ${GB_BOOT_FSTYPE} defaults,noatime 1 1" >> ${GB_ROOT}/etc/fstab
fi
