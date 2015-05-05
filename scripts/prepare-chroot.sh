#!/bin/bash
set -x
set -e

if ! cat /proc/mounts | cut -d' ' -f 2 | grep -q "^${GB_ROOT}/proc$"; then
  mount -t proc proc ${GB_ROOT}/proc
fi

if ! cat /proc/mounts | cut -d' ' -f 2 | grep -q "^${GB_ROOT}/sys$"; then
  mount --rbind /sys ${GB_ROOT}/sys
  mount --make-rslave ${GB_ROOT}/sys
fi

if ! cat /proc/mounts | cut -d' ' -f 2 | grep -q "^${GB_ROOT}/dev$"; then
  mount --rbind /dev ${GB_ROOT}/dev
  mount --make-rslave ${GB_ROOT}/dev
fi

if [ -L /dev/shm ]; then
  rm /dev/shm
  mkdir /dev/shm
  mount -t tmpfs -o nosuid,nodev,noexec shm /dev/shm
  chmod 1777 /dev/shm
fi
