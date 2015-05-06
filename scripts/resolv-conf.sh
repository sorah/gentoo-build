#!/bin/bash
set -x
set -e

rm -f ${GB_ROOT}/etc/resolv.conf
cp /etc/resolv.conf ${GB_ROOT}/etc/resolv.conf
