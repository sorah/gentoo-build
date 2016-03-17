#!/bin/bash

retval=0

err() {
  retval=1
  echo "$@" >/dev/stderr
}

if [ "_$(whoami)" != "_root" ]; then
  err "this script should run as root"
fi

if [ -n "$GB_ADD_STEPS" ]; then
  # TODO: validate
  true
fi

[ -z "$GB_STAGE3" ] && err "GB_STAGE3 is required"
[ -z "$GB_STAGE3_MIRROR" ] && err "GB_STAGE3_MIRROR is required"
[ -z "$GB_ROOTDEVICE" ] && err "GB_ROOTDEVICE is required"
[ -z "$GB_ROOT" ] && err "GB_ROOT is required"

if [ -n "$GB_PARTITIONING" ]; then
  if [ "$GB_PARTITIONING" != "1" -a "$GB_PARTITIONING" != "0" ]; then
    err "GB_PARTITIONING should be '1' or '0' or empty"
  fi
fi

if [ -z "${GB_PARTITIONING}" -o "_${GB_PARTITIONING}" = "_0" ]; then
  if [ -z "${GB_ROOT_PARTITION}" -o -z "${GB_ROOT_FSTYPE}" ]; then
    err "GB_ROOT_PARTITION and GB_ROOT_FSTYPE should be provided when GB_PARTITIONING is off"
  fi

  if [ -n "${GB_BOOT_PARTITION}" -o -n "${GB_BOOT_FSTYPE}" ]; then
    if [ -z "${GB_BOOT_PARTITION}" ]; then
      err "GB_BOOT_PARTITION is required when GB_BOOT_FSTYPE is present"
    fi

    if [ -z "${GB_BOOT_FSTYPE}" ]; then
      err "GB_BOOT_FSTYPE is required when GB_BOOT_PARTITION is present"
    fi
  fi
else
  if [ "_$GB_ROOT_FSTYPE" != "_xfs" -a "_$GB_ROOT_FSTYPE" != "_ext4" -a "_$GB_ROOT_FSTYPE" != "_btrfs" ]; then
    err "GB_ROOT_FSTYPE should be xfs or ext4 or btrfs"
  fi
fi

[ -z "$GB_HOSTNAME" ] && err "GB_HOSTNAME is required"

if [ -z "$GB_SKIP_KERNEL" ]; then
  [ -z "$GB_KERNEL_PACKAGE" ] && err "GB_KERNEL_PACKAGE is required"
  [ -z "$GB_KERNEL_CONFIG" ] && err "GB_KERNEL_CONFIG is required"
fi
[ -z "$GB_TIMEZONE" ] && err "GB_TIMEZONE is required"

exit $retval
