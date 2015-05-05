#!/bin/bash

set -x
set -e

source variables.sh

./validate.sh

if [ "_$GB_PARTITIONING" = "_1" ]; then
  ./scripts/partition.sh
  ./scripts/mount.sh
fi

./scripts/stage3.sh
./scripts/portage.sh

./scripts/fstab.sh
./scripts/resolv-conf.sh
./scripts/networking.sh
./scripts/locale.sh
./scripts/make-conf.sh
./scripts/timezone.sh

./scripts/prepare-chroot.sh

./scripts/systemd.sh
./scripts/sudo.sh
./scripts/vixie-cron.sh
./scripts/sshd.sh
./scripts/enable-network.sh
./scripts/portage-utils.sh

./scripts/kernel.sh
./scripts/grub.sh

./scripts/finalize.sh

for x in ${GB_ADD_STEPS}; do
  ./scripts/${x}.sh
done
