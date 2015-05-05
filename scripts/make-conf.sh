#!/bin/bash
set -x
set -e

mkdir -p "${GB_ROOT}/etc/portage/repos.conf"
cat <<-EOF > "${GB_ROOT}/etc/portage/repos.conf/gentoo.conf"
[DEFAULT]
main-repo = gentoo

[gentoo]
location = /usr/portage
sync-type = rsync
sync-uri = rsync://rsync.gentoo.org/gentoo-portage
auto-sync = yes
EOF
