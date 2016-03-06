#!/bin/bash

set -x
set -e

source "${1:-variables.sh}"

cd "$(dirname $0)"

./validate.sh

if [ "_$GB_PARTITIONING" = "_1" ]; then
  export GB_ROOT_PARTITION=3
  if [ -d /sys/firmware/efi ]; then
    export GB_EFI_PARTITION=1
    export GB_BOOT_PARTITION=2
  else
    export GB_BOOT_PARTITION=1
  fi
  export GB_BOOT_FSTYPE=ext4
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

if [ -z "${GB_SKIP_KERNEL}" ]; then
  ./scripts/kernel.sh
fi

if [ -z "${GB_SKIP_GRUB}" ]; then
  ./scripts/grub.sh
fi

for x in ${GB_ADD_STEPS}; do
  ./scripts/${x}.sh
done

./scripts/finalize.sh
