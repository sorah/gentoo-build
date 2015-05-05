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
  if [ "$GB_PARTITIONING" != "1" ]; then
    err "GB_PARTITIONING should be '1' or empty"
  fi
fi

if [ "_$GB_ROOT_FSTYPE" != "_xfs" -a "_$GB_ROOT_FSTYPE" != "_ext4" ]; then
  err "GB_ROOT_FSTIPE should be xfs or ext4"
fi

[ -z "$GB_HOSTNAME" ] && err "GB_HOSTNAME is required"

[ -z "$GB_KERNEL_PACKAGE" ] && err "GB_KERNEL_PACKAGE is required"
[ -z "$GB_KERNEL_CONFIG" ] && err "GB_KERNEL_CONFIG is required"
[ -z "$GB_TIMEZONE" ] && err "GB_TIMEZONE is required"

exit $retval
