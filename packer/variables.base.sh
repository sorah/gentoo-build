### Stage3, portage snapshot

export GB_STAGE3=latest
export GB_STAGE3_MIRROR="ftp://ftp.iij.ad.jp/pub/linux/gentoo"

### Root devices

export GB_ROOTDEVICE=sda
export GB_ROOT=/mnt/gentoo
export GB_PARTITIONING=1
export GB_ROOT_FSTYPE=ext4

### Networking

export GB_HOSTNAME=gentoobox

### Portage

export GB_REMOVE_PORTAGE=1

### Linux kernel

export GB_KERNEL_PACKAGE='>=sys-kernel/gentoo-sources-4.3.3'
export GB_KERNEL_CONFIG="https://gist.githubusercontent.com/sorah/b573516ef9539b7b0788/raw/00c976a9c965914ec2ddc23081aa1b3d05895a48/gistfile1.txt"

### Default user

export GB_USER_UID=999

### Timezone

export GB_TIMEZONE=UTC


case "_${PACKER_BUILDER_TYPE}" in
_virtualbox*)
  export GB_ADD_STEPS="vagrant virtualbox ${GB_ADD_STEPS}"
  export GB_USER_PASSWORD=vagrant
  export GB_USER_LOGIN=vagrant
  export GB_GRUB_NO_TIMEOUT=1
  ;;
_amazon*)
  export GB_ADD_STEPS="cloud-init aws ${GB_ADD_STEPS}"
  export GB_USER_LOGIN=
  export GB_SKIP_SUDOERS=1
  export GB_ROOTDEVICE=xvda
  export GB_PARTITIONING=0
  export GB_ROOT_PARTITION=1
  export GB_GRUB_CONSOLE=1
  export GB_GRUB_NO_TIMEOUT=1
  export GB_IFACE='eth* eno* enp* ens*'
esac

export MAKEOPTS="-j$(nproc)"

env | grep '^GB_'
env | grep 'PACKER'
