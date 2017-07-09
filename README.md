# gentoo-build

shell scripts that builds systemd based gentoo box for x86_64 platform.

## Usage

### Basic

```
$ cp ./variables{.sample,}.sh
$ vi ./variables.sh
$ ./minify.sh /tmp/gentoo-build.sh
$ scp /tmp/gentoo-build.sh installer:/tmp/gentoo-build.sh
$ ssh installer /tmp/gentoo-build.sh
```

### Packer (virtualbox-iso, amazon-ebs)

```
$ packer build --var 'subnet_id=subnet-XXX' --var 'vpc_id=vpc-XXX' packer/gentoo.json
$ packer build --only=virtualbox-iso --var 'subnet_id=' --var 'vpc_id=' packer/gentoo.json
```

packer build should be run in the repository root directory.

## Built images using packer

You can use these if you can trust me. Note that the images are provided w/o any warranty. And the images can be removed w/o any notices.
If you want persistent copy, build by your own.

### Vagrant (virtualbox, qemu, aws)

https://atlas.hashicorp.com/sorah/boxes/gentoo

Not frequently updated

### AWS EC2 AMI

<!-- s/\v^(.+): (.+)$/- \1: [`\2`](https:\/\/console.aws.amazon.com\/ec2\/home?region=\1#launchAmi=\2)/ -->

gentoo-20170706-595e850a-1ade-86bb-c236-ecf2ea883c22

- ap-northeast-1: [`ami-59d1ce3e`](https://console.aws.amazon.com/ec2/home?region=ap-northeast-1#launchAmi=ami-59d1ce3e)
- ap-south-1: [`ami-433c452c`](https://console.aws.amazon.com/ec2/home?region=ap-south-1#launchAmi=ami-433c452c)
- ap-southeast-1: [`ami-225fd541`](https://console.aws.amazon.com/ec2/home?region=ap-southeast-1#launchAmi=ami-225fd541)
- ca-central-1: [`ami-9b7cc3ff`](https://console.aws.amazon.com/ec2/home?region=ca-central-1#launchAmi=ami-9b7cc3ff)
- eu-central-1: [`ami-0442e26b`](https://console.aws.amazon.com/ec2/home?region=eu-central-1#launchAmi=ami-0442e26b)
- eu-west-2: [`ami-16c8de72`](https://console.aws.amazon.com/ec2/home?region=eu-west-2#launchAmi=ami-16c8de72)
- sa-east-1: [`ami-e5671289`](https://console.aws.amazon.com/ec2/home?region=sa-east-1#launchAmi=ami-e5671289)
- us-east-1: [`ami-0d64601b`](https://console.aws.amazon.com/ec2/home?region=us-east-1#launchAmi=ami-0d64601b)
- us-east-2: [`ami-ceedccab`](https://console.aws.amazon.com/ec2/home?region=us-east-2#launchAmi=ami-ceedccab)
- us-west-1: [`ami-a3f8d7c3`](https://console.aws.amazon.com/ec2/home?region=us-west-1#launchAmi=ami-a3f8d7c3)
- us-west-2: [`ami-77c6d50e`](https://console.aws.amazon.com/ec2/home?region=us-west-2#launchAmi=ami-77c6d50e)

## Note

### Packer virtualbox support

- default user name is `vagrant`, and its password is `vagrant`
- NOPASSWD sudo access enabled for `wheel` group, which vagrant user belongs to.

### Packer EC2 support

- cloud-init has enabled
- default user name is `gentoo`
  - NOPASSWD sudo access enabled for the user
  - default user creation is done via cloud-init.
- IPv6 is not supported out-of-the-box
  - As of Jan 31st, AWS' DHCPv6 server implementation doesn't respond to packets sent from systemd-networkd :/
