#!/bin/bash
set -x
set -e

if [ -e "${GB_ROOT}/stage3.tar.bz2" ] ; then
  echo "skipping stage3"
  exit 0
fi

if [ "${GB_STAGE3}" = "latest" ]; then
  wget -O "${GB_ROOT}/stage3.tar.bz2" "${GB_STAGE3_MIRROR}"'/releases/amd64/autobuilds/current-stage3-amd64-systemd/stage3-amd64-systemd-2*.tar.bz2'
else
  wget -O "${GB_ROOT}/stage3.tar.bz2" "${GB_STAGE3_MIRROR}/releases/amd64/autobuilds/${GB_STAGE3}/stage3-amd64-${GB_STAGE3}.tar.bz2"
fi

tar xf "${GB_ROOT}/stage3.tar.bz2" -C "${GB_ROOT}"
