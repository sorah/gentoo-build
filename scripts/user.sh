#!/bin/bash
set -x
set -e

if [ -z "${GB_USER_LOGIN}" ]; then
  echo 'skipping user'
  exit 0
fi

useradd_args="-m '${GB_USER_LOGIN}' -G wheel"
if [ -n "${GB_USER_UID}" ]; then
  groupadd="groupadd -g ${GB_USER_UID} ${GB_USER_LOGIN}"
  useradd_args="-u ${GB_USER_UID} -g ${GB_USER_UID} ${useradd_args}"
fi

chroot ${GB_ROOT} /bin/bash <<-EOF
source /etc/profile
set -x
set -e


if id '${GB_USER_LOGIN}' >/dev/null 2>&1; then
  echo 'skipping user'
  exit 0
fi

${groupadd}
useradd ${useradd_args}

if printenv GB_USER_PASSWORD | grep -q .; then
  ( echo -n '${GB_USER_LOGIN}:' && printenv GB_USER_PASSWORD ) | chpasswd
fi
EOF
