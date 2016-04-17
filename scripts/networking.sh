#!/bin/bash
set -x
set -e

if [ -n "${GB_NETWORK}" ]; then
  echo "${GB_NETWORK}"|sed -e 's/ /\n/g' > ${GB_ROOT}/etc/systemd/network/default.network
else
  iface="${GB_IFACE}"
  if [ -z "${iface}" ]; then
    iface="$(ip -o r get 8.8.8.8|sed -e's/ \+/ /g'|sed -re 's/^.*dev ([^ ]+) .*$/\1/')"
    echo "NOTICE: assuming default iface is ${iface}"
  fi

  cat > ${GB_ROOT}/etc/systemd/network/default.network <<-EOF
[Match]
Name=${iface}

[Network]
DHCP=both

[DHCP]
UseDomains=yes
EOF
fi

chroot ${GB_ROOT} /bin/bash <<-'EOF'
source /etc/profile
set -x
set -e
ln -sfv /usr/lib64/systemd/system/systemd-networkd.service /etc/systemd/system/multi-user.target.wants/systemd-networkd.service
ln -sfv /usr/lib64/systemd/system/systemd-resolved.service /etc/systemd/system/multi-user.target.wants/systemd-resolved.service
EOF
