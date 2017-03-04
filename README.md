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

gentoo-20170304-58bb1960-c7b4-4913-0503-e27fb5777159

- ap-northeast-1: [`ami-14ecbb73`](https://console.aws.amazon.com/ec2/home?region=ap-northeast-1#launchAmi=ami-14ecbb73)
- ap-south-1: [`ami-db6919b4`](https://console.aws.amazon.com/ec2/home?region=ap-south-1#launchAmi=ami-db6919b4)
- ap-southeast-1: [`ami-6343f300`](https://console.aws.amazon.com/ec2/home?region=ap-southeast-1#launchAmi=ami-6343f300)
- ca-central-1: [`ami-5267da36`](https://console.aws.amazon.com/ec2/home?region=ca-central-1#launchAmi=ami-5267da36)
- eu-central-1: [`ami-a4b460cb`](https://console.aws.amazon.com/ec2/home?region=eu-central-1#launchAmi=ami-a4b460cb)
- eu-west-2: [`ami-a5f8edc1`](https://console.aws.amazon.com/ec2/home?region=eu-west-2#launchAmi=ami-a5f8edc1)
- sa-east-1: [`ami-67dabc0b`](https://console.aws.amazon.com/ec2/home?region=sa-east-1#launchAmi=ami-67dabc0b)
- us-east-1: [`ami-c9cd68df`](https://console.aws.amazon.com/ec2/home?region=us-east-1#launchAmi=ami-c9cd68df)
- us-east-2: [`ami-a59ebbc0`](https://console.aws.amazon.com/ec2/home?region=us-east-2#launchAmi=ami-a59ebbc0)
- us-west-1: [`ami-14104974`](https://console.aws.amazon.com/ec2/home?region=us-west-1#launchAmi=ami-14104974)
- us-west-2: [`ami-6076fb00`](https://console.aws.amazon.com/ec2/home?region=us-west-2#launchAmi=ami-6076fb00)

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
