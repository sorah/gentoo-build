#!/bin/bash
set -x
set -e

mkdir -p "${GB_ROOT}"

if ! cat /proc/mounts | cut -d' ' -f 2 | grep -q "^${GB_ROOT}$"; then
  mkdir -p "${GB_ROOT}"
  mount /dev/${GB_ROOTDEVICE}${GB_ROOT_PARTITION} "${GB_ROOT}"
fi

if ! cat /proc/mounts | cut -d' ' -f 2 | grep -q "^${GB_ROOT}/boot$"; then
  mkdir -p "${GB_ROOT}/boot"
  mount /dev/${GB_ROOTDEVICE}${GB_BOOT_PARTITION} "${GB_ROOT}/boot"
fi

if [ -n "${GB_EFI_PARTITION}" ]; then
  if ! cat /proc/mounts | cut -d' ' -f 2 | grep -q "^${GB_ROOT}/boot/efi$"; then
    mkdir -p "${GB_ROOT}/boot/efi"
    mount /dev/${GB_ROOTDEVICE}${GB_EFI_PARTITION} "${GB_ROOT}/boot/efi"
  fi
fi
