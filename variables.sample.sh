### mode (optional)

# export GB_ADD_STEPS=virtualbox
# export GB_ADD_STEPS="virtualbox vagrant"
# export GB_ADD_STEPS=gce
# export GB_ADD_STEPS=aws

### Stage3, portage snapshot

export GB_STAGE3=latest
export GB_STAGE3_MIRROR="ftp://ftp.iij.ad.jp/pub/linux/gentoo/"
export GB_PORTAGE_SNAPSHOT="http://ftp.iij.ad.jp/pub/linux/gentoo/snapshots/portage-latest.tar.xz"

### Root devices

# used for disk partitioning and grub2 install destination
export GB_ROOTDEVICE=sda
export GB_ROOT=/mnt/gentoo

# let gentoo-build do disk partitioning and mount
# (note: you should maintain /etc/fstab before reboot)
export GB_PARTITIONING=1

# only ext4 and xfs is supported; if xfs has chosen, /boot will be partitioned additional, using ext4
export GB_ROOT_FSTYPE=ext4
# export GB_ROOT_FSTYPE=xfs

### Networking

export GB_HOSTNAME=gentoobox

# export GB_IFACE=eth0
# by default generates DHCP configuration
# export GB_NETWORK="[Network] Address=192.168.0.10/24 Gateway=192.168.0.1 Domains=corp DNS=8.8.8.8"

### Portage

export GB_REMOVE_PORTAGE=0

### make.conf

export GB_GENTOO_MIRRORS="http://ftp.iij.ad.jp/pub/linux/gentoo/ http://ftp.jaist.ac.jp/pub/Linux/Gentoo/ ftp://ftp.jaist.ac.jp/pub/Linux/Gentoo/"
export GB_GENTOO_SYNC="rsync://rsync.jp.gentoo.org/gentoo-portage"
#export GB_FEATURES=
#export GB_USE=

### Linux kernel

export GB_KERNEL_PACKAGE='>=gentoo-sources-4.0.1'
export GB_KERNEL_CONFIG="https://raw.githubusercontent.com/sorah/config/master/linux/gentoo.config"

### Default user

export GB_USER_UID=999
export GB_USER_LOGIN=gentoo
# optional, if omit, no password given
#export GB_USER_PASSWORD=gentoobuild

### Timezone

export GB_TIMEZONE=UTC

### distcc (optional)

# (not implemented)
# export GB_DISTCC_HOSTS=""
# export GB_DISTCC_MAKEOPTS=""



