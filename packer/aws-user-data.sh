#cloud-config
bootcmd:
  - |
    /bin/bash <<-'EOS'
    #!/bin/bash
    exec > >(tee /root/log.txt)
    exec 2>&1

    set -x
    set -e

    if [ -e /new ]; then
      # avoid loops
      exit 0
    fi

    sed -i -e 's/^Port 22$/Port 122/' /etc/ssh/sshd_config

    cat > /sbin/myinit <<-'EOF'
    #!/bin/bash
    set -x
    set -e

    mount -o rw,remount /
    mkdir -p /tmp/root
    mount none -t tmpfs /tmp/root
    cp -ax / /tmp/root
    rm -rf /tmp/root/dev
    cp -ax /dev /tmp/root/dev
    mount none -t sysfs /tmp/root/sys
    mount none -t proc /tmp/root/proc
    mount none -t devpts /tmp/root/dev/pts
    touch /old
    touch /tmp/root/new
    mkdir /tmp/root/oldroot
    mount --make-private /
    mount --make-private /tmp/root
    rm -f /tmp/root/etc/mtab
    ln -fsv /proc/self/mounts /tmp/root/etc/mtab
    pivot_root /tmp/root/ /tmp/root/oldroot
    cat /proc/mounts|cut -d ' ' -f 2 | grep '/oldroot/'| sort -r | xargs -n1 umount || true
    umount -l /oldroot/dev || true
    umount /oldroot || true
    exec /sbin/init "$@"
    EOF
    chmod +x /sbin/myinit

    echo 'GRUB_CMDLINE_LINUX="${GRUB_CMDLINE_LINUX} init=/sbin/myinit"'  >> /etc/default/grub
    grub-mkconfig -o /boot/grub/grub.cfg

    reboot
    EOS
