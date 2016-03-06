#!/bin/bash
set -x
set -e

chroot "${GB_ROOT}" /bin/bash -x -e <<-'EOF'
profile="$(find /usr/portage/profiles/default/linux/amd64 -maxdepth 2 -name 'systemd' -type d|head -n1|sed -e's|^/usr/portage/profiles/||')"
eselect profile set "${profile}"

if [ -e /usr/lib/systemd/systemd ]; then
  echo 'skipping systemd'
  exit 0
fi

emerge --unmerge sys-fs/udev || :
emerge --deselect sys-fs/udev || :
emerge --unmerge sys-fs/eudev || :
emerge --deselect sys-fs/eudev || :

ln -sf /proc/self/mounts /etc/mtab
emerge -v sys-apps/systemd
emerge -vDN @world
EOF
