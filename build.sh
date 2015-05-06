#!/bin/bash

set -x
set -e

source "${1:-variables.sh}"

./validate.sh

if [ "_$GB_PARTITIONING" = "_1" ]; then
  ./scripts/partition.sh
  ./scripts/mount.sh
fi

./scripts/stage3.sh

./scripts/fstab.sh
./scripts/resolv-conf.sh

./scripts/prepare-chroot.sh

./scripts/portage.sh
./scripts/timezone.sh
./scripts/locale.sh
./scripts/systemd.sh
./scripts/networking.sh
./scripts/hostname.sh
./scripts/user.sh

./scripts/sudo.sh
./scripts/vixie-cron.sh
./scripts/sshd.sh
./scripts/portage-utils.sh

./scripts/kernel.sh
./scripts/grub.sh

for x in ${GB_ADD_STEPS}; do
  ./scripts/${x}.sh
done

./scripts/finalize.sh
