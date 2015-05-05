#!/bin/bash
set -x
set -e

if [ -e /dev/${GB_ROOTDEVICE}1 -a -e /dev/${GB_ROOTDEVICE}2 -a -e /dev/${GB_ROOTDEVICE}3 ]; then
  echo "skipping partition"
  exit 0
fi

sgdisk \
  -n 1:0:+128M -t 1:8300 -c 1:"linux-boot" \
  -n 2:0:+32M  -t 2:ef02 -c 2:"bios-boot"  \
  -n 3:0:0     -t 3:8300 -c 3:"linux-root" \
  -p /dev/${GB_ROOTDEVICE}

mkfs.ext4 /dev/${GB_ROOTDEVICE}1

case "${GB_ROOT_FSTYPE}" in
ext4)
  mkfs.ext4 /dev/${GB_ROOTDEVICE}3
  ;;
xfs)
  mkfs.xfs /dev/${GB_ROOTDEVICE}3
  ;;
*)
  echo "unknown fs type ${GB_ROOT_FSTYPE}" >/dev/stderr
  exit 1
  ;;
esac
