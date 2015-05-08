#!/bin/bash
set -x
set -e

mkdir -p "${GB_ROOT}"

if ! cat /proc/mounts | cut -d' ' -f 2 | grep -q "^${GB_ROOT}$"; then
  mkdir -p "${GB_ROOT}"
  mount /dev/${GB_ROOTDEVICE}3 "${GB_ROOT}"
fi

if ! cat /proc/mounts | cut -d' ' -f 2 | grep -q "^${GB_ROOT}/boot$"; then
  mkdir -p "${GB_ROOT}/boot"
  mount /dev/${GB_ROOTDEVICE}1 "${GB_ROOT}/boot"
fi
