#!/bin/bash
set -x
set -e

chroot ${GB_ROOT} /bin/bash <<-'EOF'
source /etc/profile
set -x
set -e

if [ -n "$(find /lib/modules -name 'vboxsf.ko')" ]; then
  echo 'skipping vbox modules'
  exit 0
fi

if grep vboxaddition /proc/mounts; then
  umount /tmp/vboxaddition || true
fi

# We use ISO due to emerge failure...

wget -O /tmp/vboxaddition.iso http://download.virtualbox.org/virtualbox/4.3.26/VBoxGuestAdditions_4.3.26.iso
mkdir -p /tmp/vboxaddition
mount /tmp/vboxaddition.iso -o loop /tmp/vboxaddition

###

mkdir -p /root/gentoo-build-bin

cat > /root/gentoo-build-bin/uname <<-'EOC'
#!/bin/bash
case "$1" in
-r)
  echo "$(readlink /usr/src/linux|sed -e 's/^linux-//')"
  exit 0
  ;;
-m)
  echo "x86_64"
  exit 0
  ;;
*)
  exec /usr/bin/uname $@
  ;;
esac
EOC

cat > /root/gentoo-build-bin/depmod <<-'EOC'
#!/bin/bash
case "$1" in
-a)
  exec /sbin/depmod -a "$(/root/gentoo-build-bin/uname -r)"
  ;;
*)
  exec /sbin/depmod $@
  ;;
esac
EOC

chmod +x /root/gentoo-build-bin/uname
chmod +x /root/gentoo-build-bin/depmod

export PATH=/root/gentoo-build-bin:${PATH}

###

mkdir -p /root/vboxaddition
cd /root/vboxaddition

/tmp/vboxaddition/VBoxLinuxAdditions.run --tar xf
tar xf ./VBoxGuestAdditions-amd64.tar.bz2

###

cd src/vboxguest-*
make install
echo 'vboxsf' > /etc/modules-load.d/virtualbox.conf
echo 'vboxguest' >> /etc/modules-load.d/virtualbox.conf

###

cd /root

rm -rf /root/vboxaddition
rm -rf /root/gentoo-build-bin
umount /tmp/vboxaddition
EOF
